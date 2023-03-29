-- Lê Quốc Thịnh B1910453
-- Câu hỏi: Viết câu lệnh SQL trả lời các câu hỏi sau:

-- 1. Xem nội dung của tất cả các bảng dữ liệu bằng lệnh SELECT
select * from khoahoc;
select * from chuongtrinh;
select * from loailop;
select * from lop;
select * from hocvien;
select * from phieuthu;
select * from monhoc;
select * from diem;

-- 2. Tìm thông tin về các học viên nam
select * from hocvien where gioitinh=1;

-- 3. Tìm thông tin về các học viên có địa chỉ ở Cần Thơ
select * from hocvien where diachi LIKE '%Cần Thơ%';

-- 4. Tìm thông tin về các lớp học của ‘khoá 1’
select * from lop l, khoahoc k where l.makh=k.makh and lower(tenkh)='khóa 1';

-- 5. Tìm mã và họ tên học viên có học ‘khoá 1’
select h.mahv,tenhv
from hocvien h, phieuthu p, lop l, khoahoc k
where h.mahv=p.mahv and p.malop=l.malop
                    and l.makh=k.makh
                    and lower(tenkh)='khóa 1';

-- 6. Tìm họ tên các học viên có bao gồm chữ ‘Đỗ’
select tenhv from hocvien where tenhv LIKE '%Đỗ%';

-- 7. Tìm thông tin các học viên sinh năm 2000 ?
select * from hocvien where extract(year from ngaysinh)=2000;

-- 8. Tìm thông tin của các học viên sinh tháng 12 năm 2001 ?
select * from hocvien where extract(year from ngaysinh)=2001 and extract(month from ngaysinh)=12;

-- 9. Tìm thông tin các học viên sinh từ năm 1998 đến 2000
select * from hocvien where extract(year from ngaysinh) between 1998 and 2000;

-- 10. Tìm thông tin các phiếu thu được thực hiện từ ngày 5 đến ngày 10 tháng 6 năm 2021 ?
select * from phieuthu where ngaylapphieu between '2021-06-05' and '2021-06-10';

-- 11. In danh sách các học viên lớp ‘Lớp 1’ Tiếng anh căn bản
select h.*
from hocvien h JOIN phieuthu p ON h.mahv=p.mahv
                JOIN lop l ON p.malop=l.malop
                JOIN loailop ll ON l.maloai=ll.maloai
where lower(tenlop)='lớp 1' and lower(tenloai)='tiếng anh căn bản';

-- 12. In danh sách các lớp thuộc chương trình ‘Tiếng anh tổng quát’
select l.*
from lop l JOIN loailop ll ON l.maloai=ll.maloai
            JOIN chuongtrinh ct ON ll.mact=ct.mact
where lower(tenct)='tiếng anh tổng quát';

-- 13. Liệt kê thông tin tất cả các phiếu thu của ‘lớp 1’ Tiếng anh A1?
select p.*
from phieuthu p JOIN lop l ON p.malop=l.malop
                JOIN loailop ll ON l.maloai=ll.maloai
where lower(tenlop)='lớp 1' and lower(tenloai)='tiếng anh a1';

-- 14. Tìm họ tên học viên, tên môn và điểm thi các môn của các học viên học ‘khoá 1’
select h.tenhv, m.tenmh, d.diem
from hocvien h JOIN diem d ON h.mahv=d.mahv
                JOIN monhoc m ON m.mamh=d.mamh
                JOIN lop l ON l.malop=d.malop
                JOIN khoahoc k ON k.makh=l.makh
where lower(tenkh)='khóa 1';

-- 15. Có tất cả bao nhiêu học viên ?
select count(*) sohocvien from hocvien

-- 16. ‘Lớp 1’ Tiếng anh căn bản có bao nhiêu học viên ?
select count(*) sohocvien
from hocvien h JOIN phieuthu p ON h.mahv=p.mahv
                JOIN lop l ON p.malop=l.malop
                JOIN loailop ll ON l.maloai=ll.maloai
where lower(tenlop)='lớp 1' and lower(tenloai)='tiếng anh căn bản';

-- 17. Tính tổng số tiền đã thu được của ‘lớp 2’ Tiếng anh căn bản
select sum(thanhtien) tongGiaTri
from phieuthu p JOIN lop l ON p.malop=l.malop
                JOIN loailop ll ON l.maloai=ll.maloai
where lower(tenlop)='lớp 1' and lower(tenloai)='tiếng anh căn bản';

-- 18. Tính tổng số tiền đã thu được của ‘khoá 1’ ?
select sum(thanhtien) tongGiaTri
from phieuthu p JOIN lop l ON p.malop=l.malop
                JOIN khoahoc k ON l.makh=k.makh
where lower(tenkh)='khóa 1';

-- 19. Tính điểm trung bình của học viên 'Đỗ Gia Bảo', sinh ngày 02/12/2001 học ‘lớp 1’ Tiếng anh căn bản ?
select avg(diem) diemTrungBinh
from diem d JOIN hocvien h ON d.mahv=h.mahv
            JOIN lop l ON l.malop=d.malop
            JOIN loailop ll ON l.maloai=ll.maloai
where lower(tenhv)='Đỗ Gia Bảo'
    and lower(ngaysinh)='2001-12-02'
    and lower(tenlop)='lớp 1'
    and lower(tenloai)='tiếng anh căn bản';

-- 20. Tìm điểm lớn nhất ?
select max(diem) diemLonNhat from diem;


