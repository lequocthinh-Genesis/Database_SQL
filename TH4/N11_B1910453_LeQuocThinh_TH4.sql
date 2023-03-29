-- Lê Quốc Thịnh B1910453
-- Thực hành 4

-- 2. Mở các bảng dữ liệu để xem kiểu dữ liệu của từng trường và quan sát dữ liệu của từng bảng
select * from ktrucsu;
select * from chuthau;
select * from chunhan;
select * from congnhan;
select * from cgtrinh;
select * from thamgia;
select * from thietke;

-- 3. Hãy cho biết thông tin về các kiến trúc sư có họ là Lê và sinh năm 1956
select * from ktrucsu where hoten_kts LIKE 'le%' and nams_kts=1956;

-- 4. Hãy cho biết tên các công trình bắt đầu trong khoảng 1/9/1994 đến 20/10/1994
select ten_ctr from cgtrinh where ngay_bd between '9-1-1994' and '10-20-1994';

-- 5. Hãy cho biết tên và địa chỉ các công trình do chủ thầu ‘công ty xây dựng số 6’ thi công (chú ý: xem dữ liệu để lấy đúng tên công ty xây dựng số 6)
select ten_ctr, diachi_ctr from cgtrinh where ten_thau='cty xd so 6';

-- 6. Tìm tên và địa chỉ liên lạc của các chủ thầu thi công công trình ở Cần Thơ do kiến trúc sư Lê Kim Dung thiết kế
select ct.ten_thau, dchi_thau
from chuthau ct join cgtrinh cgt on ct.ten_thau=cgt.ten_thau
                join thietke tk on tk.stt_ctr=cgt.stt_ctr
                join ktrucsu kts on kts.hoten_kts=tk.hoten_kts
where tinh_thanh='can tho' and kts.hoten_kts='le kim dung';

-- 7. Hãy cho biết nơi tốt nghiệp của các kiến trúc sư đã thiết kế công trình Khách sạn quốc tế ở Cần Thơ
select kts.noi_tn
from ktrucsu kts join thietke tk on kts.hoten_kts=tk.hoten_kts
                join cgtrinh cgt on tk.stt_ctr=cgt.stt_ctr
where ten_ctr='khach san quoc te' and tinh_thanh='can tho';

-- 8. Cho biết họ tên, năm sinh và năm vào nghề của các công nhân có chuyên môn hàn hoặc điện đã tham gia các công trình mà chủ thầu Lê Văn Sơn đã trúng thầu
select cn.hoten_cn, nams_cn, nam_vao_n
from congnhan cn join thamgia tg on cn.hoten_cn=tg.hoten_cn
                 join cgtrinh cgt on cgt.stt_ctr=tg.stt_ctr
                 join chuthau ct on ct.ten_thau=cgt.ten_thau
where ch_mon='han' or ch_mon='dien' and ct.ten_thau='le van son';

-- 9. Những công nhân nào đã bắt đầu tham gia sông trình Khách sạn Quốc tế ở Cần Thơ trong giai đoạn từ ngày 15/12/1994 đến 31/12/1994
select cn.hoten_cn
from congnhan cn join thamgia tg on cn.hoten_cn=tg.hoten_cn
                 join cgtrinh cgt on cgt.stt_ctr=tg.stt_ctr
where ten_ctr='khach san quoc te'
    and tinh_thanh='can tho'
    and ngay_tgia between '12-15-1994' 
    and '12-31-1994';

-- 10. Cho biết họ tên và năm sinh của các kiến trúc sư đã tốt nghiệp ở TP HCM và đã thiết kế ít nhất một công trình có kinh phí đầu tư trên 400 triệu đồng
select kts.hoten_kts, nams_kts
from ktrucsu kts join thietke tk on kts.hoten_kts=tk.hoten_kts
                join cgtrinh cgt on tk.stt_ctr=cgt.stt_ctr
where noi_tn='tp hcm'
    and tk.stt_ctr>=1 
    and kinh_phi > 400;

-- 11. Tìm họ tên và chuyên môn của các công nhân tham gia các công trình do kiến trúc sư Lê Thanh Tùng thiết kế
select cn.hoten_cn, ch_mon
from congnhan cn join thamgia tg on cn.hoten_cn=tg.hoten_cn
                 join thietke tk on tk.stt_ctr=tg.stt_ctr
                 join ktrucsu kts on kts.hoten_kts=tk.hoten_kts
where kts.hoten_kts='le thanh tung';

-- 12. Cho biết tên công trình có kinh phí cao nhất
select ten_ctr from cgtrinh where kinh_phi= (select max(kinh_phi) from cgtrinh);

-- 13. Cho biết họ tên kiến trúc sư trẻ tuổi nhất
select hoten_kts from ktrucsu where nams_kts= (select max(nams_kts) from ktrucsu);

-- 14. Tìm tổng kinh phí của các công trình theo từng chủ thầu
select ctg.ten_ctr, ct.ten_thau, sum(ctg.kinh_phi) tongkp
from cgtrinh ctg join chuthau ct on ctg.ten_thau=ct.ten_thau
group by ctg.ten_ctr, ct.ten_thau
order by tongkp;

-- 15. Tìm tên và địa chỉ những chủ thầu đã trúng thầu công trình có kinh phí thấp nhất
select ct.ten_thau, dchi_thau
from chuthau ct join cgtrinh ctg on ct.ten_thau=ctg.ten_thau
where kinh_phi= (select min(kinh_phi) from cgtrinh);

-- 16. Cho biết họ tên các kiến trúc sư có tổng thù lao thiết kế các công trình lớn hơn 25 triệu
select kts.hoten_kts
from ktrucsu kts join thietke tk on kts.hoten_kts=tk.hoten_kts
                join cgtrinh cgt on tk.stt_ctr=cgt.stt_ctr
group by kts.hoten_kts HAVING sum(tk.thu_lao) > 25
order by kts.hoten_kts;      

-- 17. Cho biết số lượng các kiến trúc sư có tổng thù lao thiết kế các công trình lớn hơn 25 triệu
create table c17 as
select kts.hoten_kts
from ktrucsu kts join thietke tk on kts.hoten_kts=tk.hoten_kts
                join cgtrinh cgt on tk.stt_ctr=cgt.stt_ctr
group by kts.hoten_kts HAVING sum(tk.thu_lao) > 25 

select count(*) sokts
from c17;

-- 18. Tính số công trình mà mỗi kiến trúc sư đã thiết kế
select kts.hoten_kts, sum(cgt.stt_ctr) soctr
from cgtrinh cgt join thietke tk on cgt.stt_ctr=tk.stt_ctr
                join ktrucsu kts on kts.hoten_kts=tk.hoten_kts
group by kts.hoten_kts;

-- 19. Tính tổng số công nhân đã tham gia mỗi công trình
select cgt.ten_ctr, count(*) socn
from congnhan cn join thamgia tg on cn.hoten_cn=tg.hoten_cn
                 join cgtrinh cgt on cgt.stt_ctr=tg.stt_ctr
group by cgt.ten_ctr
order by cgt.ten_ctr;

-- 20. Tìm tên và địa chỉ công trình có tổng số công nhân tham gia nhiều nhất
select tg.stt_ctr, ten_ctr, diachi_ctr, count(*) socn
from thamgia tg join cgtrinh cgt on tg.stt_ctr=cgt.stt_ctr
group by tg.stt_ctr, ten_ctr, diachi_ctr
    HAVING count(*) = (select max(count(*)) from thamgia group by stt_ctr);

-- 21. Cho biết tên các thành phố và kinh phí trung bình của các công trình của từng thành phố tương ứng
select tinh_thanh, avg(kinh_phi) kpTrungBinh
from cgtrinh
group by tinh_thanh

-- 22. Cho biết tên và địa chỉ của các công trình mà công nhân Nguyễn Hồng Vân đang tham gia vào ngày 18/12/1994
select tg.stt_ctr, ten_ctr, diachi_ctr
from thamgia tg join cgtrinh cgt on tg.stt_ctr=cgt.stt_ctr
where hoten_cn='nguyen hong van'
    and 'dec-18-1994' between ngay_tgia and ngay_tgia+so_ngay;

-- 23. Cho biết họ tên kiến trúc sư vừa thiết kế các công trình do Phòng dịch vụ Sở Xây
-- dựng thi công, vừa thiết kế các công trình do chủ thầu Lê Văn Sơn thi công

select tk.hoten_kts
from cgtrinh ctr, thietke tk
where ctr.stt_ctr = tk.stt_ctr
and ctr.ten_thau = 'phong dich vu so xd'
INTERSECT
select distinct tk.hoten_kts
from cgtrinh ctr, thietke tk  
where ctr.stt_ctr = tk.stt_ctr
and ctr.ten_thau='le van son';

-- 24. Cho biết họ tên các công nhân có tham gia các công trình ở Cần Thơ nhưng không tham gia công trình ở Vĩnh Long
select hoten_kts
from thietke tk join cgtrinh cgt on tk.stt_ctr=cgt.stt_ctr
where tinh_thanh='can tho'
MINUS
select hoten_kts
from thietke tk join cgtrinh cgt on tk.stt_ctr=cgt.stt_ctr
where tinh_thanh='vinh long'

-- 25. Cho biết tên của các chủ thầu đã thi công các công trình có kinh phí lớn hơn tất cả 
-- các công trình do chủ thầu Phòng dịch vụ sở xây dựng thi công
select ten_ctr
from cgtrinh
where kinh_phi > ALL
        (select kinh_phi
        from cgtrinh
        where ten_thau='phong dich vu so xd');

-- 26. Cho biết họ tên các kiến trúc sư có thù lao thiết kế cho một công trình nào đó dưới
-- giá trị trung bình thù lao thiết kế của các KTS.
select distinct hoten_kts
from thietke 
where thu_lao < (select avg(thu_lao) from thietke);

-- 27. Cho biết họ tên các công nhân có tổng số ngày tham gia vào các công trình lớn hơn
-- tổng số ngày tham gia của công nhân Nguyễn Hồng Vân
select hoten_cn, sum(so_ngay) TongSoNgay
from thamgia
group by hoten_cn having sum(so_ngay) >
        (select sum(so_ngay)
        from thamgia
        where hoten_cn='nguyen hong van' );

-- 28. Cho biết họ tên công nhân có tham gia tất cả các công trình
select hoten_cn, count(distinct stt_ctr)
from thamgia
group by hoten_cn having count(*)=
        (select count(*)from cgtrinh);

-- 29. Tìm các cặp tên của chủ thầu có trúng thầu các công trình tại cùng một thành phố
select c1.ten_thau, c2.ten_thau
from cgtrinh c1 join cgtrinh c2 on c1.tinh_thanh=c2.tinh_thanh
where  c1.ten_thau< c2.ten_thau;

-- 30. Tìm các cặp tên của các công nhân có lamg việc chung với nhau trong ít nhất là hai
công trình
select t.hoten_cn, t1.hoten_cn
from thamgia t join thamgia t1 on t.stt_ctr=t1.stt_ctr
where t.hoten_cn < t1.hoten_cn;