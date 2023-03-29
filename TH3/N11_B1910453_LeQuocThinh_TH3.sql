--1) Xem dữ liệu của tất cả các bảng
select * from tacpham;
select * from docgia;
select * from sach;
select * from muon;

--2) Vẽ sơ đồ liên thông

--3) Các tác phẩm (NT, tựa) của tác giả 'Guy de Maupassant'.
select NT,tua from tacpham where lower(tacgia)='guy de maupassant';

--4) Các độc giả sống ở địa chỉ '32 rue des Alouettes, 75003 Paris'.
select * from docgia where lower(dchi)='32 rue des alouettes, 75003 paris';

--5) Tìm tên nhà xuất bản các tác phẩm bao gồm từ 'Fleur'
select s.nxb from sach s JOIN tacpham t ON s.nt=t.nt where tua LIKE '%Fleur%';

--6) Tìm tên các tác phẩm bắt đầu bằng 'Le'
select tua from tacpham where tua LIKE '%Le%';

--7) Tìm tên các độc giả có mượn sách trong trong khoảng thời gian từ ngày 15/9/2007 đến 20/09/2007
select d.ten from docgia d JOIN muon m ON d.nd=m.nd where ngaymuon between '9-15-2007' and '9-20-2007';

--8) Nhà xuất bản của tác phẩm tiêu đề 'Germinal'.
select s.nxb from sach s JOIN tacpham t ON s.nt=t.nt where lower(tua)='germinal ';

--9) Tên độc giả đã mượn tác phẩm 'Poésie'.
select d.ten
from docgia d JOIN muon m ON d.nd=m.nd
              JOIN sach s ON s.ns=m.ns
              JOIN tacpham t ON t.nt=s.nt
where lower(tua)='po e';

--10) Những độc giả nào đã mượn tác phẩm Les 'Fleurs du mal'
select *
from docgia d JOIN muon m ON d.nd=m.nd
              JOIN sach s ON s.ns=m.ns
              JOIN tacpham t ON t.nt=s.nt
where lower(tua)='les fleurs du mal';

--11) Tìm các tựa sách, tên độc giả của các độc giả trả sách quá thời hạn cho phép
select t.tua,d.ten
from docgia d JOIN muon m ON d.nd=m.nd
              JOIN sach s ON s.ns=m.ns
              JOIN tacpham t ON t.nt=s.nt
where ngaytra > hantra;

--12) Tìm các tựa sách, tên độc giả của các độc giả trả sách trước thời hạn
select t.tua,d.ten
from docgia d JOIN muon m ON d.nd=m.nd
              JOIN sach s ON s.ns=m.ns
              JOIN tacpham t ON t.nt=s.nt
where ngaytra < hantra;

--13) Tên độc giả đã mượn tác phẩm của 'Victor Hugo'
select d.ten
from docgia d JOIN muon m ON d.nd=m.nd
              JOIN sach s ON s.ns=m.ns
              JOIN tacpham t ON t.nt=s.nt
where lower(tacgia)='victor hugo';

--14) Tên độc giả và các tác phẩm đã được mượn năm 2007
select d.ten, t.tua
from docgia d JOIN muon m ON d.nd=m.nd
              JOIN sach s ON s.ns=m.ns
              JOIN tacpham t ON t.nt=s.nt
where extract(year from ngaymuon)=2007;

--15) Tính số tác phẩm có trong thư viện.
select count(*) sopt from tacpham;

--16) Tựa của tác phẩm mà có ít nhất hai quyển sách.
select s.nt, tua, count(*) sosach
from sach s JOIN tacpham t ON s.nt=t.nt
group by s.nt, tua having count(*)>1
order by s.nt;

--17) Tính Số tác phẩm của mỗi tác giả.
select tacgia, count(*) soTpMoiTg
from tacpham
group by tacgia
order by tacgia;

--18) Tính Số sách của mỗi tác phẩm.
select nt, count(*) sosach
from tacpham
group by nt
order by nt;

--19) Tìm số lần mượn sách của mỗi độc giả theo năm
select d.nd,extract(year from ngaymuon), count(*) solanmuon
from docgia d join muon m on d.nd=m.nd
group by d.nd, extract(year from ngaymuon)
order by d.nd;

--20) Tìm tên tác phẩm có ít nhất 3 sách
select s.nt, tua, count(*) sosach
from sach s JOIN tacpham t ON s.nt=t.nt
group by s.nt, tua having count(*)>2
order by s.nt;


--21) Tìm tên tác phẩm có nhiều sách nhất
select s.nt, tua, count(*) sosach
from sach s JOIN tacpham t ON s.nt=t.nt
group by s.NT, tua having count(*) >= ALL (select count(*) sosach from sach group by nt);

--22) Tên nhà xuất bản xuất bản nhiều sách nhất
select s.nt, nxb, count(*) sosach
from sach s JOIN tacpham t ON s.nt=t.nt
group by s.NT, nxb having count(*) >= ALL (select count(*) sosach from sach group by nt);

--23) Tính Số tác giả có ít nhất hai tác phẩm
create table c23 as
select tacgia, count(*) sotacgia
from sach s JOIN tacpham t on s.nt=t.nt
group by s.nt,tacgia having count(*)>1
order by s.nt;

select count(tacgia) from c23;

--24) Tìm tựa tác phẩm có nhiều người mượn nhất
create table c24 as 
    select m.ns, t.tua, count(*) solanmuon
    from docgia d JOIN muon m ON d.nd=m.nd
                  JOIN sach s ON s.ns=m.ns
                  JOIN tacpham t ON t.nt=s.nt
    group by m.ns, t.tua;

select tua from c24 where solanmuon = (select max(solanmuon) from c24);

--25) Tìm tựa tác phẩm có ít người mượn nhất
select tua from c24 where solanmuon = (select min(solanmuon) from c24);

--26) Tìm độc giả mượn nhiều tác phẩm nhất
create table c26 as 
    select m.nd, d.ten, count(*) solanmuon
    from docgia d JOIN muon m ON d.nd=m.nd
                  JOIN sach s ON s.ns=m.ns
                  JOIN tacpham t ON t.nt=s.nt
    group by m.nd, d.ten;

select nd, ten from c26 where solanmuon = (select max(solanmuon) from c26);

--27) Tìm tên độc giả mượn ít tác phẩm nhất
select nd, ten from c26 where solanmuon = (select min(solanmuon) from c26);

--28) Tìm tên tác phẩm có ít nhất một quyển sách không ai mượn
select distinct tua
from tacpham t JOIN sach s on s.nt=t.nt left JOIN muon m ON s.ns=m.ns
where ngaymuon is null
order by tua;

--28) Tìm tên tác phẩm có ít nhất một quyển sách không ai mượn (lồng nhau)
select distinct tua
from tacpham t JOIN sach s on s.nt=t.nt
where ns IN 
    (select ns from sach
    MINUS
    select ns from muon);

--29) Tìm tên tác phẩm có tất cả các quyển sách đều được mượn
select tua
from tacpham
where nt NOT IN (select nt
                from sach s left JOIN muon m ON s.ns=m.ns
                where ngaymuon is NULL);

--30) Tìm họ tên độc giả chưa mượn quyển sách nào
select distinct d.ho, ten
from tacpham t JOIN sach s on s.nt=t.nt 
               left JOIN muon m ON s.ns=m.ns
               right JOIN docgia d ON d.nd=m.nd
where ngaymuon is null
order by d.ho;

--31) Tìm thông tin về nhà suất bản của quyển sách mà chưa được ai mượn
select distinct *
from tacpham t JOIN sach s on s.nt=t.nt left JOIN muon m ON s.ns=m.ns
where ngaymuon is null
order by s.ns;

