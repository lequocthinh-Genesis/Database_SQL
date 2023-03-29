-- Cau 1:

-- Lenh kiem tra ngay mac dinh tren apex
select sysdate from dual;

-- KHOAHOC (MAKH,TENKH,NGAYBD, NGAYKT)
create table khoahoc (
    makh char(4) primary key,
    tenkh varchar(20) not null,
    ngaybd date not null,
    ngaykt date not null,
    constraint kh_ck CHECK(ngaybd<ngaykt)
);
-- Lenh xoa bang khoahoc
drop table khoahoc;


-- CHUONGTRINH (MACT,TENCT)
create table chuongtrinh (
    mact char(5) primary key,
    tenct varchar(50) not null
);
-- Lenh xoa bang chuongtrinh
drop table chuongtrinh;


-- LOAILOP (MALOAI, MACT, TENLOAI)
create table loailop (
    maloai char(5) primary key,
    mact char(5) references chuongtrinh(mact),
    tenloai varchar(50) not null
);
-- Lenh xoa bang loailop
drop table loailop;


-- LOP (MALOP, MALOAI, TENLOP, SISO, MAKH)
create table lop (
    malop char(4) primary key,
    maloai char(5) not null,
    tenlop varchar(50) not null,
    siso smallint not null check(siso>12),
    makh char(4) references khoahoc(makh),
    constraint lop_FK foreign key(maloai) references loailop(maloai)
);
-- Lenh xoa bang lop
drop table lop;


-- HOCVIEN (MAHV,TENHV,GIOITINH,NGAYSINH,SDT,DIACHI)
create table hocvien (
    mahv char(6) primary key,
    tenhv varchar(20) not null,
    gioitinh char(1) check(gioitinh in ('0', '1')),
    ngaysinh date not null,
    sdt char(10),
    diachi varchar(50)
);
-- Lenh xoa bang hocvien
drop table hocvien;


-- PHIEUTHU(SOPT,MAHV, MALOP,NGAYLAPPHIEU,THANHTIEN)
create table phieuthu (
    sopt char(8) primary key,
    mahv char(6) references hocvien(mahv),
    malop char(4) references lop(malop),
    ngaylapphieu date not null,
    thanhtien int check(thanhtien>0)
);
-- Lenh xoa bang phieuthu
drop table phieuthu;


-- MONHOC (MAMH, TENMH)
create table monhoc (
    mamh char(5) primary key,
    tenmh varchar(20) not null
);
-- Lenh xoa bang monhoc
drop table monhoc;


-- DIEM (MAMH,MAHV,MALOP,DIEM)
create table diem (
    mamh char(5) references monhoc(mamh),
    mahv char(4) references hocvien(mahv),
    malop char(4) references lop(malop),
    diem numeric(4,2) check(diem>=0 AND diem<=10),
    primary key (mamh, mahv, malop) 
);
-- Lenh xoa bang diem
drop table diem;



-- Cau 2:

-- Them du lieu vao bang khoahoc
insert into khoahoc values('K001','Khóa 1', '2020-01-10', '2020-03-20');
insert into khoahoc values('K002','Khóa 2', '2020-02-28', '2020-05-28');
insert into khoahoc values('K003','Khóa 3', '2020-04-10', '2020-07-20');
insert into khoahoc values('K004','Khóa 4', '2020-06-15', '2020-09-20');

-- Them du lieu vao bang chuongtrinh
insert into chuongtrinh values('CT007','Chứng Chỉ Tiếng Anh 6 Bậc (A1, B1, B2, C1)');
insert into chuongtrinh values('CT006','chương trình Cambridge');
insert into chuongtrinh values('CT005','Tiếng Anh IELTS');
insert into chuongtrinh values('CT004','Chương Trình TOEIC');
insert into chuongtrinh values('CT003','Tiếng Anh Luyện Kỹ Năng');
insert into chuongtrinh values('CT002','Tiếng Anh Trẻ Em');
insert into chuongtrinh values('CT001','Tiếng Anh Tổng Quát');

-- Them du lieu vao bang loailop
insert into loailop values('LL001','CT001', 'Tiếng Anh Căn Bản');
insert into loailop values('LL002','CT001', 'Tiếng Anh A1');
insert into loailop values('LL003','CT001', 'Tiếng Anh A2');
insert into loailop values('LL004','CT001', 'Tiếng Anh B1');
insert into loailop values('LL005','CT001', 'Tiếng Anh B2');
insert into loailop values('LL006','CT001', 'Tiếng Anh C1');

-- Them du lieu vao bang lop
insert into lop values('L001', 'LL001', 'lớp 1', '30', 'K001');
insert into lop values('L002', 'LL001', 'lớp 2', '30', 'K001');
insert into lop values('L003', 'LL002', 'lớp 1', '25', 'K001');

-- them du lieu vao bang hocvien
insert into hocvien values('HV0001','Đỗ Bình An', '1', '2000-11-02', '917217036', 'Cờ Đỏ - Cần thơ');
insert into hocvien values('HV0002','Đỗ Gia Bảo', '1', '2000-12-02', '917217036', 'Ô Môn - Cần thơ');
insert into hocvien values('HV0003','Đỗ Phúc vinh', '1', '2000-11-02', '917217036', 'cù Lao Dung - Sóc Trăng');
insert into hocvien values('HV0004','Thạch Chí Tâm', '1', '2000-01-02', '917217036', 'Châu Thành - An Giang');
insert into hocvien values('HV0005','Lê Cẩm giao', '0', '2000-11-05', '917217036', 'Phong Điền - Cần thơ');
insert into hocvien values('HV0006','Huỳnh Gia Bảo', '1', '2000-11-02', '917217036', 'Phong Điền - Cần thơ');

-- them du lieu vao bang phieuthu
insert into phieuthu values('PT000002','HV0002', 'L001', '2021-06-01', '1350000');
insert into phieuthu values('PT000003','HV0002', 'L001', '2021-06-01', '1350000');
insert into phieuthu values('PT000004','HV0002', 'L001', '2021-06-01', '1350000');
insert into phieuthu values('PT000005','HV0002', 'L001', '2021-06-01', '1350000');
insert into phieuthu values('PT000006','HV0002', 'L001', '2021-06-01', '1350000');
insert into phieuthu values('PT000007','HV0002', 'L001', '2021-06-01', '1350000');



-- Cau 3. Thêm dòng dữ liệu ('PT00008','HV0012','L001','06-02-2021',1350000) vào PHIEUTHU ? Dòng này có thêm vào được không ? Giải thích tại sao ?

insert into phieuthu values('PT00008','HV0012', 'L001', '06-02-2021', '1350000');

-- kết quả : Dòng này không thêm vào được bởi vì Không tồn tại mã học viên(mahv) HV0012 trong bảng hocvien và ngày thêm vào nhập sai định dạng



-- câu 4. Thêm dòng dữ liệu ('L004','LL002','Lớp 4',10,'K001') vào LOP ? Dòng này có thêm vào được không ? Giải thích tại sao ?

insert into lop values('L004', 'LL002', 'lớp 4', 10, 'K001');

-- Kết quả: dòng này không thêm vào được bởi vì số 10 không để trong dấu cặp dấu nháy '' nên sai cú pháp



-- Câu 5. Xóa khoá học có mã 'K001', khoá học này có xoá được không ? Giải thích tại sao ?

delete from khoahoc where makh='K001';

-- Kết quả; không xóa được khóa học này bởi vì Trong bảng lop có khóa ngoại là makh và giá trị makh='K001' có tồn tai trong bảng lop, xóa sẽ ảnh hưởng đến dữ liệu của bảng lop



-- cau 6. Xóa khoá học có mã 'K002', khoá học này có xoá được không ? Giải thích tại sao ?

delete from khoahoc where makh='K002';

-- Kết quả; xóa được khóa học này bởi vì Trong bảng lop có khóa ngoại là makh và không có giá trị makh='K002' tồn tai trong bảng lop, xóa sẽ không ảnh hưởng đến dữ liệu của bảng lop


-- câu 7. Giảm giá trị cột thành tiền của phiếu thu 000002 xuống 10%
-- ta có 10% của 1.350.000 là 135.000 
-- Giảm xuống 10% => 1.350.000 - 135.000 = 1.215.000
-- Ta cập nhật giá trị mới chó phiếu thu 000002 
update phieuthu set thanhtien='1215000' where sopt='PT000002';


-- Câu 8: Thêm vào quan hệ LOP cột hocphi và cập nhật giá trị cho cột này như sau:
alter table lop add hocphi int check(hocphi>0);
-- 1) 1350000 cho loại lớp LL001
update lop set hocphi='1215000' where maloai='LL001';
-- 2) 1650000 cho loại lớp LL002
update lop set hocphi='1650000' where maloai='LL002';



-- Câu 9: Tạo bảng HOCVIEN_NAM(MAHV,TENHV,SDT,NGAYSINH,DIACHI), chỉ bao gồm các học viên giới tính nam (0)

create table hocvien_nam (
    mahv char(6) primary key,
    tenhv varchar(20) not null,
    sdt char(10),
    ngaysinh date not null,
    diachi varchar(50)
);
-- Lenh xoa bang hocvien_nam
drop table hocvien_nam;

-- Câu 10. Lấy dữ liệu tự động từ bảng HOCVIEN thêm vào bảng HOCVIEN_NAM vừa tạo

insert into hocvien_nam(mahv, tenhv, sdt, ngaysinh, diachi)
select mahv, tenhv, sdt, ngaysinh, diachi
from hocvien
where gioitinh='1';

-- Câu 11. Xoá Bảng KHOAHOC, bảng này xoá được không ? Giải thích tại sao ?

drop table khoahoc;

-- Kết quả; không xóa được bảng khóa học bởi vì Trong bảng lop có khóa ngoại là makh xóa sẽ ảnh hưởng đến dữ liệu của bảng lop


-- câu 12. Xoá bảng HOCVIEN_NAM bảng này xoá được không ? Giải thích tại sao ?
drop table hocvien_nam;

-- Kết quả xóa được bỏi vì bảng hocvien_nam không có khóa ngoại và các bảng khác không có lên kết khóa ngoại với bảng hocvien_nam

-- Câu 13. Đổi kiểu dữ liệu của cột tenMH trong bảng MONHOC thành VARCHAR(100)
alter table monhoc modify tenmh varchar(100);