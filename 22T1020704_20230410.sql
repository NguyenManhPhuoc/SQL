--1.Hãy cho biết thông tin về các ngành đào tạo và đơn vị quản lý ngành đó
	SELECT *
	FROM DonVi AS d
		JOIN NganhDaoTao AS n ON h.MaDonVi = n.MaDonVi
--2.Hiển thị danh sách các học phần do 'Khoa Tiếng Anh chuyên ngành' phụ trách
SELECT h.MaHocPhan,h.TenHocPhan,h.SoTinChi
FROM HocPhan AS h 
		LEFT JOIN DonVi AS d ON h.MaDonVi = d.MaDonVi
WHERE d.TenDonVi = N'Khoa Tiếng Anh chuyên ngành'
--3.Hãy cho biết danh sách các ngành đào tạo được tuyển sinh trong khoảng thời gian từ năm 2010
--đến năm 2014
SELECT n.MaNganh,n.TenNganh
FROM NganhDaoTao AS n 
	JOIN KhoaHoc_NganhDaoTao AS kn ON	n.MaNganh = kn.MaNganh
	JOIN KhoaHoc AS k ON kn.MaKhoaHoc = k.MaKhoaHoc
WHERE k.NamTuyenSinh BETWEEN  2010 AND 2014
--4. Hiển thị danh sách mã sinh viên, họ tên, giới tính, ngày sinh và nơi sinh của các sinh viên Ngành
--'Tiếng Anh' được tuyển sinh trong năm 2013. Dữ liệu hiển thị sắp xếp theo tên, họ
SELECT sv.MaSinhVien,sv.HoDem,sv.Ten,sv.NgaySinh,sv.GioiTinh,sv.NoiSinh
FROM SinhVien AS sv 
	JOIN NganhDaoTao AS n ON sv.MaNganh = n.MaNganh 
	JOIN KhoaHoc_NganhDaoTao AS kn ON	n.MaNganh = kn.MaNganh
	JOIN KhoaHoc AS k ON kn.MaKhoaHoc = k.MaKhoaHoc
WHERE n.TenNganh = N'Tiếng Anh' AND k.NamTuyenSinh = '2013'
ORDER BY sv.HoDem,sv.Ten ASC
--5.In danh sách các sinh viên của lớp 'Đọc 5 - Nhóm 13' mở trong học kỳ 1 năm học 2014-2015.
--Sắp xếp danh sách theo họ, tên.
SELECT sv.*
FROM SinhVien AS sv 
	JOIN LopHocPhan_SinhVien AS ls ON sv.MaSinhVien = ls.MaSinhVien
	JOIN LopHocPhan AS l ON ls.MaLopHocPhan = l.MaLopHocPhan
WHERE l.TenLopHocPhan =N'Đọc 5 - Nhóm 13'
AND l.MaHocKy =	N'2014-2015.1'
ORDER BY sv.HoDem,sv.Ten ASC
--6.Hãy cho biết điểm QTHT và điểm thi lần 1 của các sinh viên thuộc lớp học phần 'Nói 3 - Nhóm
--1' mở trong học kỳ 1 năm học 2012-2013.
SELECT sv.*,ls.DiemQTHT,ld.DiemThi,ld.LanThi
FROM SinhVien AS sv
	JOIN LopHocPhan_SinhVien AS ls ON sv.MaSinhVien = ls.MaSinhVien
	JOIN LopHocPhan AS l ON ls.MaLopHocPhan = l.MaLopHocPhan
	JOIN LopHocPhan_DiemThi AS ld ON ls.MaLopHocPhan = ld.MaLopHocPhan
WHERE l.TenLopHocPhan =N'Nói 3 - Nhóm 1'
AND l.MaHocKy=N'2012-2013.1'
AND ld.LanThi=N'1'
--7.Hãy cho biết mã sinh viên, họ tên, ngày sinh, nơi sinh, tên khóa học và tên ngành học của các
--sinh viên Nữ, sinh tại 'Quảng Trị' nhập học trong khoảng thời gian từ năm 2005 đến năm 2010
--(Lưu ý: năm nhập học căn cứ vào năm tuyển sinh của Khóa học)
SELECT sv.MaSinhVien,sv.HoDem,sv.Ten,sv.NgaySinh,sv.NgaySinh,k.TenKhoaHoc,n.TenNganh
FROM KhoaHoc AS k
	JOIN SinhVien AS sv ON k.MaKhoaHoc = sv.MaKhoaHoc
	JOIN NganhDaoTao AS n ON sv.MaNganh = n.MaNganh
WHERE sv.GioiTinh = N'FALSE'
AND sv.NoiSinh = N'Quảng Trị' 
AND  k.NAMTUYENSINH BETWEEN 2005 AND 2010
--8.Hiển thị danh sách mã sinh viên, họ tên, ngày sinh, nơi sinh, tên khóa học, tên ngành và năm
--nhập học của các sinh viên Nam thuộc họ 'Nguyễn Phúc' hoặc sinh viên Nữ thuộc họ 'Tôn Nữ'
SELECT sv.MaSinhVien,sv.HoDem,sv.Ten,sv.NgaySinh,sv.NoiSinh,k.TenKhoaHoc,n.TenNganh,k.NamTuyenSinh
FROM KhoaHoc AS k
	LEFT JOIN SinhVien AS sv ON k.MaKhoaHoc = sv.MaKhoaHoc
	LEFT JOIN NganhDaoTao AS n ON sv.MaNganh = n.MaNganh
WHERE (sv.GioiTinh = N'TRUE' AND sv.HoDem = N'Nguyễn Phúc')
OR (sv.GioiTinh= N'FALSE' AND sv.HoDem = N'Tôn Nữ')
--9.Hiển thị mã lớp, tên lớp, mã học phần, số tín chỉ và tên đơn vị phụ trách chuyên môn của những
--lớp học phần được mở trong học kỳ 2 năm học 2013-2014.
SELECT l.MaLopHocPhan,l.TenLopHocPhan,hp.MaHocPhan,hp.SoTinChi,d.TenDonVi,l.MaHocKy
FROM LopHocPhan AS l 
	JOIN HocPhan AS hp ON l.MaHocPhan = hp.MaHocPhan
	JOIN DonVi AS d ON hp.MaDonVi = d.MaDonVi
WHERE l.MaHocKy =N'2013-2014.2'
--10.Hãy cho biết danh sách các lớp học phần mà 'Khoa Việt Nam học' phụ trách trong năm học
--2012-2013, sắp xếp theo học kỳ và mã học phần.
SELECT l.MaLopHocPhan,l.TenLopHocPhan,d.TenDonVi
FROM LopHocPhan AS l 
	JOIN HocPhan AS hp ON l.MaHocPhan = hp.MaHocPhan
	JOIN DonVi AS d ON hp.MaDonVi = d.MaDonVi
WHERE d.TenDonVi = N'Khoa Việt Nam học'

ORDER BY l.MaHocKy,l.MaHocPhan ASC
--11. Lấy danh sách các sinh viên của 'Khóa 5 - Chính quy' ngành 'Sư phạm Tiếng Anh' sinh ở 3 tỉnh
--thuộc vùng Bình-Trị-Thiên.
SELECT sv.MaSinhVien,sv.HoDem,sv.Ten,sv.NoiSinh,k.TenKhoaHoc,n.TenNganh
FROM NganhDaoTao AS n
	JOIN KhoaHoc_NganhDaoTao AS kn ON n.MaNganh = kn.MaNganh
	JOIN KhoaHoc AS k ON kn.MaKhoaHoc=k.MaKhoaHoc
	JOIN SinhVien AS sv ON n.MaNganh = sv.MaNganh
WHERE k.TenKhoaHoc=N'Khóa 5 - Chính quy'
AND n.TenNganh=N'Sư phạm Tiếng Anh'
AND sv.NoiSinh=N'Quảng Bình'
OR sv.NoiSinh=N'Quảng Trị'
OR sv.NoiSinh=N'Thừa Thiên Huế'
--12. Trong học kỳ 1 năm học 2014-2015, giáo viên 'Hồng Thị Cúc Anh' được phân công giảng dạy
--những lớp học phần nào với số giờ phải dạy cho mỗi lớp là bao nhiêu
SELECT gv.HoDem,gv.Ten,l.MaHocKy,l.TenLopHocPhan,lg.SoGioDay
FROM GiaoVien AS gv
	JOIN LopHocPhan_GiaoVien AS lg ON gv.MaGV = lg.MaGV
	JOIN LopHocPhan AS l ON lg.MaLopHocPhan=l.MaLopHocPhan
WHERE l.MaHocKy=N'2014-2015.1'
AND gv.HoDem=N'Hồng Thị Cúc'
AND gv.Ten=N'Anh'
--13. Lấy danh sách toàn bộ sinh viên của 'Khoa Tiếng Nga', dữ liệu hiển thị sắp xếp theo năm nhập
--học, và tên - họ của sinh viên
SELECT sv.MaSinhVien,sv.HoDem,sv.Ten,d.TenDonVi
FROM KhoaHoc AS k
JOIN KhoaHoc_NganhDaoTao AS kn ON k.MaKhoaHoc = kn.MaKhoaHoc
JOIN SinhVien AS sv ON kn.MaKhoaHoc = sv.MaKhoaHoc AND sv.MaNganh= KN.MaNganh
JOIN NganhDaoTao AS n ON sv.MaNganh = n.MaNganh 
JOIN DonVi AS d ON n.MaDonVi=d.MaDonVi
WHERE d.TenDonVi=N'Khoa Tiếng Nga'
ORDER BY k.NamTuyenSinh,sv.HoDem,sv.Ten ASC
--14. Hãy cho biết mã lớp, tên lớp, số tín chỉ, điểm QTHT và điểm thi lần 1 của các lớp học phần mà
--sinh viên 'Bùi Thị Hạnh Nhân' đã đăng ký học (Yêu cầu: những lớp mà sinh viên chưa có điểm
--thi cũng phải hiển thị với điểm thi là -1.0)
SELECT l.MaLopHocPhan,l.TenLopHocPhan,H.SoTinChi,ls.DiemQTHT,ld.DiemThi,ld.LanThi
FROM (LopHocPhan AS l 
	JOIN HocPhan AS h ON l.MaHocPhan=h.MaHocPhan
	JOIN LopHocPhan_SinhVien AS ls ON l.MaLopHocPhan= ls.MaLopHocPhan
	JOIN SinhVien AS sv ON ls.MaSinhVien= sv.MaSinhVien)
	LEFT JOIN LopHocPhan_DiemThi AS ld ON 
		ls.MaLopHocPhan=ld.MaLopHocPhan
		AND ls.MaSinhVien=ld.MaSinhVien
		AND ld.LanThi=N'1'
WHERE sv.HoDem=N'Bùi Thị Hạnh' 
AND sv.Ten=N'Nhân'
--15. Hãy lập danh sách các sinh viên phải thi lại môn 'Ngữ nghĩa học' trong học kỳ 1 năm học 2012-
--2013 (Lưu ý: sinh viên phải thi lại nếu điểm thi lần 1 bị điểm F)
SELECT sv.MaSinhVien,sv.HoDem,sv.Ten,h.TenHocPhan,l.MaHocKy ,ld.DiemChu
FROM SinhVien AS sv 
	JOIN LopHocPhan_SinhVien AS ls ON sv.MaSinhVien=ls.MaSinhVien
	JOIN LopHocPhan_DiemThi AS ld ON ls.MaSinhVien = ld.MaSinhVien AND ls.MaLopHocPhan=ld.MaLopHocPhan
	JOIN LopHocPhan AS l ON ld.MaLopHocPhan= l.MaLopHocPhan
	JOIN HocPhan AS h ON l.MaHocPhan=h.MaHocPhan
WHERE h.TenHocPhan=N'Ngữ nghĩa học' AND l.MaHocKy=N'2012-2013.1'
AND ld.DiemChu=N'F'
--16. Hãy cho biết mã lớp, tên lớp, mã học phần, số tín chỉ và đơn vị phụ trách của những lớp học
--phần mà hệ số điểm QTHT của lớp không tuân theo đúng hệ số đã được qui định bởi học phần đó
SELECT l.MaLopHocPhan,l.TenLopHocPhan,h.SoTinChi,d.TenDonVi,H.HsDiemQTHT
FROM LopHocPhan AS l 
	JOIN HocPhan AS h ON l.MaHocPhan=h.MaHocPhan
	JOIN DonVi AS d ON h.MaDonVi=d.MaDonVi
WHERE l.HsDiemQTHT != h.HsDiemQTHT
--17. Hãy cho biết những sinh viên nào của lớp 'Quản trị du lịch - Nhóm 2' (mở trong học kỳ 1 năm
--học 2014-2015) đăng ký học muộn so với thời gian qui định, đăng ký muộn bao nhiêu ngày so
--với thời gian qui định?
SELECT sv.HoDem,sv.Ten,L.TenLopHocPhan,L.MaHocKy,
DATEDIFF(y,l.NgayHetHanDangKy,ls.NgayDangKy) AS [Số ngày đăng kí muộn]
FROM SinhVien AS sv 
	JOIN LopHocPhan_SinhVien AS ls ON sv.MaSinhVien=ls.MaSinhVien
	JOIN LopHocPhan AS l ON ls.MaLopHocPhan=l.MaLopHocPhan
WHERE l.TenLopHocPhan=N'Quản trị du lịch - Nhóm 2'
AND l.MaHocKy=N'2014-2015.1'
AND ls.NgayDangKy > l.NgayHetHanDangKy
--18. Mỗi khóa học hiện có bao nhiêu sinh viên, trong đó có bao nhiêu sinh viên nam, bao nhiêu sinh
--viên nữ? Kết quả hiển thị theo mẫu sau:
--Mã khóa học Tên khóa học Tổng số SV Số SV nam Số SV nữ
SELECT k.MaKhoaHoc AS N'Mã Khoá Học',k.TenKhoaHoc AS N'Tên Khoá Học',
COUNT (k.MaKhoaHoc) AS N'Tổng Số SV',
SUM (CASE sv.GioiTinh
		WHEN N'True' THEN 1
		ELSE 0 
	END) AS N'Số SV Nam',
SUM (CASE sv.GioiTinh
		WHEN N'False' THEN 1
		ELSE 0 
	END) AS N'Số SV nữ'
FROM KhoaHoc AS k 
	LEFT JOIN KhoaHoc_NganhDaoTao AS kn ON k.MaKhoaHoc=kn.MaKhoaHoc
	LEFT JOIN SinhVien AS sv ON kn.MaNganh=sv.MaNganh AND sv.MaKhoaHoc =kn.MaKhoaHoc
GROUP BY k.MaKhoaHoc,k.TenKhoaHoc
--19. Mỗi ngành đào tạo của trường có bao nhiêu sinh viên, trong đó có bao nhiêu sinh viên nam, bao
--nhiêu sinh viên nữ? Kết quả hiển thị theo mẫu sau:
--Mã ngành Tên ngành Tổng số SV Số SV nam Số SV nữ
SELECT n.MaNganh AS N'Mã Ngành',n.TenNganh AS N'Tên Ngành',COUNT(N.MaNganh) AS N'Tổng số SV',
SUM (CASE sv.GioiTinh 
		WHEN N'True' THEN 1
		ELSE 0
	END) AS N'Số SV nam',
SUM (CASE sv.GioiTinh
		WHEN N'False' THEN 1
		ELSE 0
	END) AS N'Số SV nữ'
FROM NganhDaoTao AS n 
	LEFT JOIN KhoaHoc_NganhDaoTao AS kn ON n.MaNganh = kn.MaNganh
	LEFT JOIN SinhVien AS sv ON kn.MaKhoaHoc = sv.MaKhoaHoc AND kn.MaNganh=sv.MaNganh
GROUP BY n.MaNganh,n.TenNganh
--20. Số lượng sinh viên của mỗi khóa, ngành là bao nhiêu?
SELECT k.MaKhoaHoc,k.TenKhoaHoc,n.MaNganh,n.TenNganh,
COUNT(sv.MaSinhVien) AS [So sv moi khoa],
COUNT(sv.MaSinhVien) AS [So sv moi nganh]
FROM KhoaHoc_NganhDaoTao AS kn
	JOIN NganhDaoTao AS n ON kn.MaNganh=n.MaNganh
	JOIN KhoaHoc AS k ON kn.MaKhoaHoc=k.MaKhoaHoc
	JOIN SinhVien AS sv ON kn.MaKhoaHoc= sv.MaKhoaHoc AND kn.MaNganh=sv.MaNganh
GROUP BY k.MaKhoaHoc,k.TenKhoaHoc,n.MaNganh,n.TenNganh
--21. Mỗi đơn vị hiện đang quản lý bao nhiêu ngành đào tạo?
SELECT d.TenDonVi,COUNT(n.MaNganh) AS [Số ngành quản lí]
FROM DonVi AS d 
	JOIN NganhDaoTao AS n ON d.MaDonVi=n.MaDonVi
GROUP BY d.TenDonVi
ORDER BY d.TenDonVi
--22. Mỗi đơn vị hiện đang phải phụ trách bao nhiêu học phần?
SELECT d.TenDonVi,COUNT(h.TenHocPhan) AS [Học phần phụ trách]
FROM DonVi AS d 
	JOIN HocPhan AS h ON d.MaDonVi=d.MaDonVi
GROUP BY d.TenDonVi
--23. Mỗi đơn vị hiện đang có bao nhiêu giáo viên, bao nhiêu nam, bao nhiêu nữ, bao nhiêu Tiến sĩ,
--bao nhiêu Thạc sĩ?
SELECT d.MaDonVi,d.TenDonVi,
COUNT(gv.MaGV) AS [Số lượng GV],
SUM(CASE gv.GioiTinh
	WHEN N'True' THEN 1
	ELSE 0
	END) AS [Số GV nam],
SUM(CASE gv.GioiTinh
	WHEN N'False' THEN 1
	ELSE 0
	END) AS [Số GV nữ],
COUNT(gv.HocVi=N'Tiến sĩ' AS [Số lượng Tiến sĩ]),
COUNT(gv.HocVi=N'Thạc sĩ' AS [Số lượng Thạc sĩ])
FROM GiaoVien AS gv 
	JOIN DonVi AS d ON gv.MaDonVi=d.MaDonVi

--24. Thống kê số lượng sinh viên nhập học của từng đơn vị theo từng khóa học.
SELECT d.TenDonVi,k.TenKhoaHoc,COUNT(sv.MaSinhVien) AS [Số lượng sv nhập học]
FROM SinhVien AS sv 
	LEFT JOIN KhoaHoc AS k ON sv.MaKhoaHoc=K.MaKhoaHoc
	LEFT JOIN KhoaHoc_NganhDaoTao AS kn ON sv.MaKhoaHoc=kn.MaKhoaHoc
	LEFT JOIN NganhDaoTao AS n ON kn.MaNganh=n.MaNganh
	LEFT JOIN DonVi AS d ON n.MaDonVi=d.MaDonVi
GROUP BY d.TenDonVi,k.TenKhoaHoc
--25. Thống kê số lượng sinh viên nhập học của các ngành thuộc khóa tuyển sinh năm 2013
SELECT n.TenNganh,COUNT(SV.MaSinhVien) AS [Số lượng sv nhập học],k.NamTuyenSinh
FROM SinhVien AS sv 
	LEFT JOIN KhoaHoc AS k ON sv.MaKhoaHoc=K.MaKhoaHoc
	LEFT JOIN KhoaHoc_NganhDaoTao AS kn ON sv.MaKhoaHoc=kn.MaKhoaHoc
	LEFT JOIN NganhDaoTao AS n ON kn.MaNganh=n.MaNganh
WHERE k.NamTuyenSinh LIKE '2013'
GROUP BY n.TenNganh,K.NamTuyenSinh

SELECT 
(
SELECT COUNT(sv.MaSinhVien)
FROM KhoaHoc AS k
	JOIN SinhVien AS sv ON k.MaKhoaHoc = sv.MaKhoaHoc
	Join NganhDaoTao AS n ON sv.MaNganh = n.MaNganh AND sv.MaKhoaHoc = n.MaNganh
)
FROM KhoaHoc AS k 
	JOIN SinhVien AS sv ON k.MaKhoaHoc = sv.MaKhoaHoc
	JOIN NganhDaoTao AS n ON sv.MaNganh = n.MaNganh

--26. Trong học kỳ 1 năm học 2014-2015, những lớp học phần nào có số lượng sinh viên đăng ký
--chưa đủ số lượng tối thiểu.
SELECT DISTINCT l.TenLopHocPhan,l.MaHocKy,l.SoSinhVienToiThieu
FROM SinhVien AS sv 
	JOIN LopHocPhan_SinhVien AS ls ON sv.MaSinhVien= ls.MaSinhVien
	JOIN LopHocPhan AS l ON ls.MaLopHocPhan=l.MaLopHocPhan
WHERE l.MaHocKy=N'2014-2015.1' AND (l.SoSinhVienToiThieu < 30)
OR (l.SoSinhVienToiThieu BETWEEN 31 AND 39)
OR (l.SoSinhVienToiThieu BETWEEN 41 AND 49)
GROUP BY l.TenLopHocPhan,l.MaHocKy,l.SoSinhVienToiThieu
--27. Thống kê số lượng giờ mà mỗi giáo viên phải dạy trong năm học 2014-2015.
SELECT gv.HoDem,gv.Ten,SUM(lg.SoGioDay) AS SOLUONGGIO
FROM GiaoVien AS gv 
	JOIN LopHocPhan_GiaoVien AS lg ON gv.MaGV=lg.MaGV
	JOIN LopHocPhan AS l ON lg.MaLopHocPhan= l.MaLopHocPhan
WHERE l.MaHocKy LIKE N'2014-2015%'
GROUP BY gv.HoDem,gv.Ten
--28. Những giáo viên nào trong năm học 2014-2015 có tổng số giờ dạy vượt chuẩn.
SELECT gv.HoDem,gv.Ten,SUM(lg.SoGioDay) AS TONGGIODAY,
(CASE
	WHEN SUM(lg.SoGioDay) > '260' AND  SUM(lg.SoGioDay) > '280'  THEN gv.DinhMucGioChuan ELSE NULL
END) AS [Tong gio vuot chuan]
FROM GiaoVien AS gv 
	JOIN LopHocPhan_GiaoVien AS lg ON gv.MaGV=lg.MaGV
	JOIN LopHocPhan AS l ON lg.MaLopHocPhan= l.MaLopHocPhan
WHERE l.MaHocKy LIKE '2014-2015%'
GROUP BY gv.HoDem,gv.Ten,gv.DinhMucGioChuan
--29. Trong học kỳ 1 năm học 2014-2015, mỗi một đơn vị phải phụ trách bao nhiêu học phần, bao
--nhiêu lớp học phần?
SELECT l.MaHocKy,d.TenDonVi,COUNT(h.MaHocPhan) AS [Số học phần],COUNT(l.MaLopHocPhan) AS [Số lớp học phần]
FROM DonVi AS d 
	JOIN HocPhan AS h ON d.MaDonVi= h.MaDonVi
	JOIN LopHocPhan AS l ON h.MaHocPhan=l.MaHocPhan
WHERE l.MaHocKy LIKE '2014-2015%'
GROUP BY l.MaHocKy,d.TenDonVi
SELECT *
FROM DonVi AS d 
	JOIN HocPhan AS h ON d.MaDonVi= h.MaDonVi
	JOIN LopHocPhan AS l ON h.MaHocPhan=l.MaHocPhan
WHERE l.MaHocKy=N'2014-2015.1'

--30. Thống kê xem mỗi sinh viên của khóa ‘Khóa 10- chính quy’ ngành ‘Tiếng Anh’ trong học kỳ 1
--năm học 2014-2015 đăng ký học bao nhiêu lớp học phần, tổng số tín chỉ đăng ký là bao nhiêu?
SELECT  sv.HoDem,sv.Ten,k.TenKhoaHoc,n.TenNganh,l.MaHocKy,
COUNT(distinct l.MaLopHocPhan) AS [So lop hoc phan dang ki],
SUM(h.SoTinChi) AS [Tong so tin chi dang ki]
FROM SinhVien AS sv 
	LEFT JOIN KhoaHoc_NganhDaoTao AS kn ON sv.MaKhoaHoc=kn.MaKhoaHoc
	AND sv.MaNganh=kn.MaNganh
	LEFT JOIN KhoaHoc AS k ON kn.MaKhoaHoc=k.MaKhoaHoc
	LEFT JOIN NganhDaoTao AS n ON kn.MaNganh=n.MaNganh
	LEFT JOIN LopHocPhan_SinhVien AS ls ON sv.MaSinhVien = ls.MaSinhVien
	LEFT JOIN LopHocPhan AS l ON ls.MaLopHocPhan = l.MaLopHocPhan
	LEFT JOIN HocPhan AS h ON l.MaHocPhan = h.MaHocPhan
WHERE k.TenKhoaHoc=N'Khóa 10- chính quy'
AND n.TenNganh=N'Tiếng Anh'
AND l.MaHocKy LIKE '2014-2015%'
GROUP BY  sv.HoDem,sv.Ten,k.TenKhoaHoc,n.TenNganh,l.MaHocKy
ORDER BY sv.HoDem,sv.Ten,k.TenKhoaHoc,n.TenNganh,l.MaHocKy
--31.Năm học 2014-2015, mức thu học phí được qui định như sau:
-- Đối với các ngành Sư phạm: không thu học phí
-- Các ngành còn lại: mức thu là 250000 đồng/tín chỉ
--Hãy cho biết trong năm học 2014-2015, mỗi sinh viên (có đăng ký học) phải nộp bao nhiêu tiền
--học phí.
SELECT sv.MaSinhVien,CONCAT(sv.HoDem,' ',sv.Ten) AS HOTEN,SUM(h.SoTinChi) AS TONGTINCHI,n.TenNganh,
CASE 
     WHEN (n.TenNganh LIKE N'Sư phạm%') THEN 0 ELSE SUM(h.SoTinChi) * 250000
END AS HOCPHI
FROM SinhVien AS sv 
	JOIN NganhDaoTao AS n ON sv.MaNganh = n.MaNganh
	JOIN LopHocPhan_SinhVien AS ls ON sv.MaSinhVien = ls.MaSinhVien
	JOIN LopHocPhan AS l ON ls.MaLopHocPhan = l.MaLopHocPhan
	JOIN HocPhan AS h ON l.MaHocPhan = h.MaHocPhan
WHERE l.MaHocKy LIKE '2014-2015%'
GROUP BY sv.MaSinhVien,CONCAT(sv.HoDem,' ',sv.Ten),n.TenNganh

SELECT t.*,
	CASE 
		WHEN t.TenNganh LIKE N'Sư phạm%' THEN 0 ELSE t.TONGTINCHI * 250000
	END AS HOCPHI
FROM
(
	SELECT sv.MaSinhVien,CONCAT(sv.HoDem,' ',sv.Ten) AS HOTEN,SUM(h.SoTinChi) AS TONGTINCHI,n.TenNganh
	FROM SinhVien AS sv 
		JOIN NganhDaoTao AS n ON sv.MaNganh = n.MaNganh
		JOIN LopHocPhan_SinhVien AS ls ON sv.MaSinhVien = ls.MaSinhVien
		JOIN LopHocPhan AS l ON ls.MaLopHocPhan = l.MaLopHocPhan
		JOIN HocPhan AS h ON l.MaHocPhan = h.MaHocPhan
	WHERE l.MaHocKy LIKE '2014-2015%'
GROUP BY sv.MaSinhVien,CONCAT(sv.HoDem,' ',sv.Ten),n.TenNganh
) AS t

--32. Hãy cho biết, trong năm học 2014-2015 khối lượng giảng dạy trung bình của giảng viên mỗi
--khoa là bao nhiêu giờ (khối lượng giảng dạy trung bình = tổng số giờ dạy của giáo viên/tổng số
--giáo viên của khoa)
--33. Khóa tuyển sinh năm 2013, ngành nào có số lượng sinh viên nhập học nhiều nhất, là bao nhiêu
--sinh viên?
SELECT n.MaNganh,n.TenNganh,COUNT(sv.MaSinhVien) AS Soluong
FROM KhoaHoc AS k 
	JOIN SinhVien AS sv ON k.MaKhoaHoc= sv.MaKhoaHoc
	JOIN NganhDaoTao AS n ON sv.MaNganh =n.MaNganh
WHERE k.NamTuyenSinh = 2013
GROUP BY n.MaNganh,n.TenNganh
HAVING COUNT(sv.MaSinhVien) >= ALL
	(
		SELECT  COUNT(sv.MaSinhVien) AS Soluong
		FROM KhoaHoc AS k 
			JOIN SinhVien AS sv ON k.MaKhoaHoc= sv.MaKhoaHoc
			JOIN NganhDaoTao AS n ON sv.MaNganh =n.MaNganh
		WHERE k.NamTuyenSinh = 2013
		GROUP BY n.MaNganh,n.TenNganh
	)
--34. Trong từng khóa tuyển sinh, những ngành nào có số lượng tuyển sinh nằm trong top 3 số
--lượng nhiều nhất? là bao nhiêu sinh viên?
SELECT k.MaKhoaHoc,k.TenKhoaHoc,n.MaNganh,n.TenNganh,COUNT(sv.MaSinhVien) AS Soluong
FROM KhoaHoc AS k 
	JOIN SinhVien AS sv ON k.MaKhoaHoc = sv.MaKhoaHoc
	JOIN NganhDaoTao AS n ON sv.MaNganh= n.MaNganh
GROUP BY K.MaKhoaHoc,K.TenKhoaHoc,n.MaNganh,n.TenNganh
HAVING COUNT (sv.MaSinhVien) IN
	(
	SELECT TOP(3) COUNT(sv.MaSinhVien) AS Soluong
	FROM KhoaHoc AS k 
		JOIN SinhVien AS sv ON k.MaKhoaHoc = sv.MaKhoaHoc
		JOIN NganhDaoTao AS n ON sv.MaNganh= n.MaNganh
	GROUP BY k.MaKhoaHoc,k.TenKhoaHoc,n.MaNganh,n.TenNganh
	ORDER BY 1 DESC
	)
--35. Trong năm học 2014-2015, những giáo viên nào có tổng số giờ dạy nhiều nhất, là bao nhiêu
--giờ?
SELECT gv.MaGV,
CONCAT(gv.HoDem,' ',gv.Ten) AS HOVATEN,
SUM(lg.SoGioDay) AS TONGGIODAY
FROM GiaoVien AS gv 
	 JOIN LopHocPhan_GiaoVien AS lg ON gv.MaGV = lg.MaGV
	 JOIN LopHocPhan AS l ON lg.MaLopHocPhan = l.MaLopHocPhan
WHERE l.MaHocKy LIKE '2014-2015%'
GROUP BY gv.MaGV,CONCAT(gv.HoDem,' ',gv.Ten)
HAVING SUM(lg.SoGioDay) >=
	(
	SELECT TOP(1) SUM(lg.SoGioDay) AS TONGGIODAY
	FROM GiaoVien AS gv 
	 JOIN LopHocPhan_GiaoVien AS lg ON gv.MaGV = lg.MaGV
	 JOIN LopHocPhan AS l ON lg.MaLopHocPhan = l.MaLopHocPhan
WHERE l.MaHocKy LIKE '2014-2015%'
GROUP BY gv.MaGV,CONCAT(gv.HoDem,' ',gv.Ten)
ORDER BY TONGGIODAY DESC
	)
--36. Hãy cho biết những giáo viên có tổng số giờ dạy nhiều nhất trong từng đơn vị trong năm học
--2014-2015.
SELECT d.MaDonVi,d.TenDonVi,gv.MaGV,
CONCAT(gv.HoDem,' ',gv.Ten) AS HOVATEN,SUM(lg.SoGioDay) AS TONGGIODAY
FROM DonVi AS d
	JOIN GiaoVien AS gv ON d.MaDonVi=gv.MaDonVi
	JOIN LopHocPhan_GiaoVien AS lg ON gv.MaGV=lg.MaGV
	JOIN LopHocPhan AS l ON lg.MaLopHocPhan=l.MaLopHocPhan
WHERE l.MaHocKy LIKE '2014-2015%'
GROUP BY d.MaDonVi,d.TenDonVi,gv.MaGV,CONCAT(gv.HoDem,' ',gv.Ten)
HAVING SUM(lg.SoGioDay)	>=
	(
	SELECT TOP(1) SUM(lg1.SoGioDay) AS TONGGIODAY1
	FROM DonVi AS d1
	JOIN GiaoVien AS gv1 ON d1.MaDonVi=gv1.MaDonVi
	JOIN LopHocPhan_GiaoVien AS lg1 ON gv1.MaGV=lg1.MaGV
	JOIN LopHocPhan AS l1 ON lg1.MaLopHocPhan=l1.MaLopHocPhan
WHERE l1.MaHocKy LIKE '2014-2015%' AND d.TenDonVi = d1.TenDonVi
GROUP BY d1.MaDonVi,d1.TenDonVi,gv1.MaGV,CONCAT(gv1.HoDem,' ',gv1.Ten)
ORDER BY TONGGIODAY1 DESC
	)
--37.
SELECT n.MaNganh AS [Mã ngành],n.TenNganh AS [Tên ngành],
	COUNT(CASE WHEN sv.MaKhoaHoc = N'K8' THEN sv.MaSinhVien ELSE NULL END) AS K8,
	COUNT(CASE WHEN sv.MaKhoaHoc= N'K9' THEN sv.MaSinhVien ELSE NULL END) AS K9,
	COUNT(CASE WHEN sv.MaKhoaHoc = N'K10' THEN sv.MaSinhVien ELSE NULL END) AS K10,
	COUNT(CASE WHEN sv.MaKhoaHoc = N'K11' THEN sv.MaSinhVien ELSE NULL END) AS K11
FROM KhoaHoc AS k
	 LEFT JOIN SinhVien AS sv ON k.MaKhoaHoc = sv.MaKhoaHoc
	 RIGHT JOIN NganhDaoTao AS n ON sv.MaNganh = n.MaNganh
GROUP BY n.MaNganh,n.TenNganh
--38.
SELECT sv.MaSinhVien AS [Mã Sinh Viên], CONCAT(sv.HoDem,' ',sv.Ten) AS [Họ Tên],
ls.DiemQTHT AS [Điểm QTHT],ld.DiemThi,ld.LanThi,ld.DiemHe10 AS [Điểm hệ 10 lần 2],
(CASE WHEN ld.LanThi =N'1' THEN ld.DiemThi ELSE NULL END) AS [Điểm thi lần 1],
(CASE WHEN ld.LanThi =N'1' THEN ld.DiemHe10 ELSE NULL END) AS [Điểm hệ 10 lần 1],
(CASE WHEN ld.LanThi =N'2' THEN ld.DiemThi ELSE NULL END) AS [Điểm thi lần 2],
(CASE WHEN ld.LanThi =N'2' THEN ld.DiemHe10 ELSE NULL END) AS [Điểm hệ 10 lần 2]
FROM SinhVien AS sv
	JOIN LopHocPhan_SinhVien AS ls ON sv.MaSinhVien = ls.MaSinhVien
	JOIN LopHocPhan_DiemThi AS ld ON ls.MaLopHocPhan = ld.MaLopHocPhan
WHERE ls.MaLopHocPhan LiKE '2013-2014.1.LCT1063.020'
GROUP BY sv.MaSinhVien, CONCAT(sv.HoDem,' ',sv.Ten),ls.DiemQTHT ,ld.DiemThi,ld.LanThi,ld.DiemHe10 

-- Sửa c38
SELECT lan1.MaSinhVien,lan1.DiemQTHT,lan1.Diemthilan1,lan2.Diemthilan2
FROM
(
SELECT ls.MaSinhVien,ls.DiemQTHT,ld.DiemThi AS Diemthilan1
FROM LopHocPhan_SinhVien AS ls
	LEFT JOIN LopHocPhan_DiemThi AS ld ON ls.MaLopHocPhan = ld.MaLopHocPhan
	AND ls.MaSinhVien = ld.MaSinhVien
	AND ld.LanThi = 1
WHERE ls.MaLopHocPhan = '2013-2014.1.LCT1063.020'
) AS lan1
LEFT JOIN 
(
SELECT ld.MaSinhVien,ld.DiemThi AS Diemthilan2
FROM LopHocPhan_DiemThi AS ld
WHERE ld.MaLopHocPhan = '2013-2014.1.LCT1063.020'
AND ld.LanThi = 2
) AS lan2 ON lan1.MaSinhVien = lan2.MaSinhVien


