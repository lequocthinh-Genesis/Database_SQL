-- Lê Quốc Thịnh B1910453
-- Bài thực hành số 5

-- 2) Loại của máy 'p8'
select l.*
from loai l join may m on l.idloai=m.idloai
where idmay='p8';

-- 3) Tên của các phần mềm 'UNIX'
select pm.tenpm
from phanmem pm join loai l on pm.idloai=l.idloai
where l.idloai='UNIX';

-- 4) Tên phòng, địa chỉ IP phòng, mã phòng của các máy loại 'UNIX' hoặc 'PCWS'
select p.tenphong, p.ip, p.mp
from phong p join may m on p.mp=m.mp
             join loai l on l.idloai=m.idloai
where l.idloai='UNIX' or l.idloai='PCWS';

-- 5) Tên phòng, địa chỉ IP phòng, mã phòng của các máy loại 'UNIX' hoặc 'PCWS' ở
-- khu vực '130.120.80', sắp xếp kết quả tăng dần theo mã phòng
select p.tenphong, p.ip, p.mp
from phong p join khuvuc k on p.ip=k.ip
             join may m on m.mp=p.mp
where (m.idloai='UNIX' or m.idloai='PCWS')
    and k.ip='130.120.80'
order by p.mp;

-- 6) Số các phần mềm được cài đặt trên máy 'p6'
select count(*) SoPM
from phanmem pm join caidat cd on pm.idpm=cd.idpm
                join may m on m.idmay=cd.idmay
where m.idmay='p6';

-- 7) Số các máy đã cài phần mềm 'log1'
select count(*) SoMay
from phanmem pm join caidat cd on pm.idpm=cd.idpm
                join may m on m.idmay=cd.idmay
where pm.idpm='log1';

-- 8) Tên và địa chỉ IP (ví dụ: 130.120.80.1) đầy đủ của các máy loại 'TX'
select tenmay, IP || '.' || ad IPdaydu
from may
where idloai='TX';

-- 9) Tính số phần mềm đã cài đặt trên mỗi máy
select m.idmay, count(*) SoPM
from phanmem pm join caidat cd on pm.idpm=cd.idpm
                join may m on m.idmay=cd.idmay
group by m.idmay
order by m.idmay;

-- 10) Tính số máy mỗi phòng
select p.mp, count(*) SoMay
from may m join phong p on m.mp=p.mp
group by p.mp
order by p.mp;

-- 11) Tính số cài lần cài đặt của mỗi phần mềm trên các máy khác nhau
select pm.idpm, count(*) SoLanCai
from caidat cd join phanmem pm on cd.idpm=pm.idpm
               join may m on m.idmay=cd.idmay
group by pm.idpm
order by SoLanCai;

-- 12) Giá trung bình của các phần mềm UNIX
select avg(gia) GiaTB
from phanmem
where idloai='UNIX';

-- 13) Ngày mua phần mềm gần nhất
select ngaymua
from phanmem
where ngaymua=(select max(ngaymua) from phanmem);

-- 14) Số máy có ít nhất 2 phần mềm
select m.idmay, tenmay, count(*) SoPM
from caidat cd join phanmem pm on cd.idpm=pm.idpm
               join may m on m.idmay=cd.idmay 
group by m.idmay, tenmay having count(*) > 1
order by SoPM;

-- 15) Tìm các loại không thuộc loại máy
select l.*
from may m right join loai l on m.idloai=l.idloai
where m.idloai is null

-- 16) Tìm các loại thuộc cả hai loại máy và loại phần mềm
select l.idloai, count(*) SoLoaiPM
from may m join loai l on m.idloai=l.idloai
           join phanmem pm on pm.idloai=l.idloai
group by l.idloai having count(*) > 1

-- 17) Tìm các loại máy không phải là loại phần mềm
select m.idmay, tenmay
from caidat cd right join phanmem pm on cd.idpm=pm.idpm
               right join may m on m.idmay=cd.idmay 
where pm.idloai is null

-- 18) Địa chỉ IP đầy đủ của các máy cài phần mềm 'log6'
select IP || '.' || ad IPdaydu
from phanmem pm join caidat cd on pm.idpm=cd.idpm
                join may m on m.idmay=cd.idmay
where pm.idpm='log6';

-- 19) Địa chỉ IP đầy đủ của các máy cài phần mềm tên 'Oracle 8'
select IP || '.' || ad IPdaydu
from phanmem pm join caidat cd on pm.idpm=cd.idpm
                join may m on m.idmay=cd.idmay
where pm.tenpm='Oracle 8';

-- 20) Tên của các khu vực có chính xác 3 máy loại 'TX'
create table c20 as
    select k.tenkhuvuc, idloai
    from khuvuc k join may m on k.ip=m.ip
    where idloai='TX';

select tenkhuvuc, count(*) SoMay
from c20
group by tenkhuvuc having count(*) = 3;

-- 21) Tên phòng có ít nhất một máy cài phần mềm tên 'Oracle 6'
select distinct tenphong
from phong p join may m on p.mp=m.mp
            join caidat cd on cd.idmay=m.idmay
            join phanmem pm on pm.idpm=cd.idpm
where tenpm='Oracle 6';

-- 22) Tên phần mềm được mua gần nhất
select tenpm
from phanmem
where ngaymua=(select max(ngaymua) from phanmem);

-- 23) Tên của phần mềm PCNT có giá lớn hơn bất kỳ giá của một phần mềm UNIX nào
select tenpm
from phanmem
where idloai='PCNT' and gia > any (select gia
                                    from phanmem
                                    where idloai='UNIX');
-- 24) Tên của phần mềm UNIX có giá lớn hơn tất cả các giá của các phần mềm PCNT
select tenpm, max(gia) GiaLN
from phanmem
where idloai='UNIX'
group by tenpm having max(gia) > ALL (select gia from phanmem where idloai='PCNT');

-- 25) Tên của máy có ít nhất một phần mềm chung với máy 'p6'
select idmay 
from caidat
where idmay<>'p6' and idpm IN
(select idpm from caidat where idmay='p6');

-- 26) Tên của các máy có cùng phần mềm như máy 'p6' (có thể nhiều phần mềm hơn máy 'p6')
select idmay
from caidat c join(select idpm from caidat where idmay='p6') p on c.idpm=p.idpm
where idmay<>'p6'
group by idmay having count(*) = (select count(*) from caidat where idmay='p6');

-- 27) Tên của các máy có chính xác các phần mềm như máy 'p2'
create table c27 as
    select idmay
    from caidat c join (select idpm from caidat where idmay='p2') p on c.idpm=p.idpm
    where idmay<>'p2'
    group by idmay having count(*) = (select count(8) from caidat where idmay='p2');
select idmay
from c27
where idmay in (select idmay
                from caidat
                group by idmay having count(*) = (select count(*) from caidat where idmay='p2'));
drop table c27;

