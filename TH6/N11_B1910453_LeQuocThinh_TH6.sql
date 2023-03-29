-- BÀI THỰC HÀNH BUỔI 6
-- 1. Thêm khóa chính cho các bảng đã cho
-- Đặt thuộc tính "ten" là khóa ngoài của bảng LUI_TOI và AN
-- Thêm ràng buộc giá>0 cho cột "gia" của bảng PHUC_VU

alter table NGUOI_AN add constraint pk_nguoian primary key (ten);
alter table LUI_TOI add constraint pk_luitoi primary key (ten, quanPizza);
alter table AN add constraint pk_an primary key (ten, pizza);
alter table PHUC_VU add constraint pk_phucvu primary key (quanPizza, pizza, gia);

alter table LUI_TOI add constraint fk_luitoi foreign key (ten) references NGUOI_AN(ten);
alter table AN add constraint fk_an foreign key (ten) references NGUOI_AN(ten);

alter table PHUC_VU add constraint chk_phucvu CHECK (gia>0);


-- 2. Cho biết quán ‘Pizza Hut’ đã phục vụ các bánh pizza nào ?
select pizza
from phuc_vu
where quanpizza='Pizza Hut';

-- 3. Danh sách các bánh pizza mà các quán có bán ?
select quanpizza, pizza
from phuc_vu;

-- 4. Cho biết tên các quán có phục vụ các bánh pizza mà tên gồm chữ ‘m’
select quanpizza
from phuc_vu
where pizza LIKE '%m%';

-- 5. Tìm tên và tuổi của người ăn đã đến quán ‘Dominos’, sắp xếp kết quả giảm dần theo tuổi?
select distinct n.ten,tuoi
from nguoi_an n join lui_toi l on n.ten=l.ten
                join phuc_vu p on p.quanpizza=l.quanpizza
order by tuoi DESC;

-- 6. Tìm tên quán pizza và số bánh pizza mà mỗi quán phục vụ ?
select quanpizza, count(*) SoBanh
from phuc_vu
group by quanpizza
order by sobanh;

-- 7. Tìm tên những quán pizza phục vụ pizza với giá cao nhất ?
select distinct quanpizza
from phuc_vu
where gia=(select max(gia) from phuc_vu);

-- 8. Tìm tên các quán có phục vụ ít nhất một bánh pizza mà “Ian” thích ăn ?
select distinct quanpizza
from phuc_vu
where pizza IN
    (select pizza
    from an
    where ten='Ian');

-- 9. Tìm tên các quán có phục vụ ít nhất một bánh mà “Eli” không thích ?
select distinct quanpizza
from phuc_vu
where pizza NOT IN
    (select pizza
    from an
    where ten='Eli');

-- 10.Tìm tên các quán chỉ phục vụ các bánh mà “Eli” thích ?
select quanpizza
from phuc_vu
where quanpizza NOT IN   
    (select quanpizza
    from phuc_vu
    where pizza NOT IN
        (select pizza
        from an
        where ten='Eli'));

-- 11.Tên quán có phục vụ bánh với giá lớn hơn tất cả bánh phục vụ bởi quán ‘New York Pizza’
select quanpizza
from phuc_vu
where gia > ALL (select gia from phuc_vu where quanpizza='New York Pizza');

-- 12.Tìm tên các quán chỉ phục vụ các bánh có giá nhỏ hơn 10 ?
select quanpizza
from phuc_vu
where gia < 10;

-- 13.Tìm tên bánh được phục vụ bởi quán ‘New York Pizza’ và quán ‘Dominos’
select pizza
from phuc_vu
where quanpizza='New York Pizza'
UNION
select pizza
from phuc_vu
where quanpizza='Dominos';

-- 14.Tìm tên bánh được phục vụ bởi quán ‘Little Caesars’ và không phục vụ bởi quán 'Pizza Hut'
select pizza
from phuc_vu
where quanpizza='Little Caesars'
MINUS
select pizza
from phuc_vu
where quanpizza='Pizza Hut';

-- 15.Tìm tên các quán có phục vụ tất cả các loại bánh pizza?
select quanpizza 
from phuc_vu
group by quanpizza having count(distinct pizza)=(select count(distinct pizza) from phuc_vu);

-- 16.Tên quán phục vụ ít nhất 2 bánh pizza mà ‘Gus’ thích ?
select quanpizza
from phuc_vu p join an a on p.pizza=a.pizza
where ten='Gus'
group by quanpizza having count(*) >= 2

-- 17.Tìm tên các quán có phục vụ tất cả các bánh mà ‘Ian’ thích
select quanpizza
from phuc_vu p join (select pizza from an where ten='Ian') c on p.pizza=c.pizza
group by quanpizza having count(distinct p.pizza) = (select count(*) from an where ten='Ian');

-- 18.Tên người ăn lui tới ít nhất 3 quán?
select ten
from lui_toi 
group by ten having Count(*) >2

-- 19.Tính số loại pizza mà mỗi quán có bán ?
select quanpizza, count(distinct pizza) SoLoai
from phuc_vu
group by quanpizza

-- 20.Tìm tên người ăn thích các bánh ít nhất là giống các bánh mà Hil thích ?
select ten
from an
where ten <>'Hil' and pizza IN
(select pizza from an where ten='Hil');
