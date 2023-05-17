---------------------------------------------------------------------------------------------------------------
-- Mã sinh viên: 22T1020704
-- Họ và tên: Nguyễn Mạnh Phước
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
-- 1. Hiển thị mã sinh viên, họ, tên, ngày sinh, tên khóa học, tên ngành học và ngày đăng ký của các sinh viên 
-- lớp 'Ngữ nghĩa học - Nhóm 8', mở trong học kỳ 1 năm học 2014-2015. Dữ liệu sắp xếp theo tên và họ của sinh viên
---------------------------------------------------------------------------------------------------------------
SELECT sv.MaSinhVien,sv.HoDem,sv.Ten,SV.NgaySinh,k.TenKhoaHoc,n.TenNganh,ls.NgayDangKy
FROM 
	 LopHocPhan AS l 
	 JOIN LopHocPhan_SinhVien AS ls on l.MaLopHocPhan = ls.MaLopHocPhan 
	 JOIN  SinhVien AS sv ON ls.MaSinhVien = sv.MaSinhVien
	 JOIN KhoaHoc_NganhDaoTao AS kn ON sv.MaKhoaHoc = kn.MaKhoaHoc AND sv.MaNganh = kn.MaNganh
	 JOIN KhoaHoc AS k ON kn.MaKhoaHoc = k.MaKhoaHoc
	 JOIN NganhDaoTao AS n ON sv.MaNganh = n.MaNganh
WHERE l.TenLopHocPhan = N'Ngữ nghĩa học - Nhóm 8'
AND l.MaHocKy = '2014-2015.1'
ORDER BY sv.Ten,sv.HoDem

---------------------------------------------------------------------------------------------------------------
-- 2. Hãy cho biết kết quả thi lần 1 của tất cả sinh viên học lớp 'Ngữ nghĩa học - Nhóm 8', 
-- mở trong học kỳ 1 năm học 2014-2015. Thông tin cần biết bao gồm mã sinh viên, họ, tên, ngày sinh, 
-- điểm quá trình học tập, điểm thi, điểm hệ 10, điểm hệ 4 và điểm chữ.
---------------------------------------------------------------------------------------------------------------
SELECT *
FROM (SinhVien AS sv 
	JOIN LopHocPhan_SinhVien AS ls ON sv.MaSinhVien = ls.MaSinhVien
	JOIN LopHocPhan AS l ON ls.MaLopHocPhan = l.MaLopHocPhan)
	LEFT JOIN LopHocPhan_DiemThi AS ld ON ls.MaLopHocPhan = ld.MaLopHocPhan AND ls.MaSinhVien = ld.MaSinhVien
	AND l.TenLopHocPhan =N'Ngữ nghĩa học - Nhóm 8'
	AND l.MaHocKy = '2014-2015.1'
WHERE ld.DiemThi LIKE '1'
GROUP BY sv.MaSinhVien,sv.HoDem,sv.Ten,sv.NgaySinh,ls.DiemQTHT,ld.DiemThi,ld.DiemHe10,ld.DiemHe4,ld.DiemChu,ld.LanThi

SELECT sv.MaSinhVien,sv.HoDem,sv.Ten,sv.NgaySinh,ls.DiemQTHT,ld.DiemThi,ld.DiemHe10,ld.DiemHe4,ld.DiemChu,
(SELECT ld1.DiemThi,ld1.LanThi
FROM SinhVien AS sv
	JOIN  LopHocPhan_DiemThi AS ld1 ON sv.MaSinhVien = ld.MaSinhVien
WHERE ld.LanThi LIKE '1' AND ld1.LanThi = ld.LanThi
GROUP BY ld1.DiemThi,ld1.LanThi) AS diemthilan1
FROM SinhVien AS sv 
	JOIN LopHocPhan_SinhVien AS ls ON sv.MaSinhVien = ls.MaSinhVien
	JOIN LopHocPhan AS l ON ls.MaLopHocPhan = l.MaLopHocPhan
	JOIN LopHocPhan_DiemThi AS ld ON ls.MaLopHocPhan = ld.MaLopHocPhan AND ls.MaSinhVien = ld.MaSinhVien
WHERE l.TenLopHocPhan =N'Ngữ nghĩa học - Nhóm 8'
	AND l.MaHocKy = '2014-2015.1'
---------------------------------------------------------------------------------------------------------------
-- 3. Thống kê tổng số giờ dạy mỗi học kỳ của giáo viên thuộc 'Khoa Tiếng Anh' trong năm học 2023-2014. 
-- Kết quả thống kê được hiển thị với các thông tin theo mẫu sau:
--	  Mã giáo viên	  Họ 	tên		Tổng số giờ học kỳ 1	Tổng số giờ học kỳ 2	Tổng số giờ cả năm học
--
-- (Lưu ý: Học kỳ, năm học được xác định dựa trên mã học kỳ của lớp học phần)
---------------------------------------------------------------------------------------------------------------
SELECT gv.MaGV AS [Mã giáo viên], gv.HoDem AS [Họ], gv.Ten AS [Tên],
(SELECT SUM(lg.SoGioDay),lg.MaGV
FROM LopHocPhan AS l
	JOIN LopHocPhan_GiaoVien AS lg ON l.MaLopHocPhan = lg.MaLopHocPhan
WHERE l.MaHocKy = '2023-2024.1'
GROUP BY lg.MaGV
) AS [Tổng số giờ học kì 1],
(SELECT SUM(lg.SoGioDay),lg.MaGV
FROM LopHocPhan AS l
	JOIN LopHocPhan_GiaoVien AS lg ON l.MaLopHocPhan = lg.MaLopHocPhan
WHERE l.MaHocKy = '2023-2024.2'
GROUP BY lg.MaGV
) AS [Tổng số giờ học kì 2],
(SELECT SUM(lg.SoGioDay),lg.MaGV
FROM LopHocPhan AS l
	JOIN LopHocPhan_GiaoVien AS lg ON l.MaLopHocPhan = lg.MaLopHocPhan
WHERE l.MaHocKy = '2023-2024%'
GROUP BY lg.MaGV
) AS [Tổng số giờ cả năm học]
FROM DonVi AS d 
	JOIN GiaoVien AS gv ON d.MaDonVi = gv.MaDonVi
	JOIN LopHocPhan_GiaoVien AS lg ON gv.MaGV = lg.MaGV
	JOIN LopHocPhan AS l ON lg.MaLopHocPhan = l.MaLopHocPhan
WHERE d.TenDonVi = N'Khoa Tiếng Anh'
AND l.MaHocKy = '2023-2024%'
GROUP BY gv.MaGV,gv.HoDem,gv.Ten,d.MaDonVi,d.TenDonVi

---------------------------------------------------------------------------------------------------------------
-- 4. Thống kê tổng số tín chỉ đã học và điểm trung bình học kỳ (tính theo điểm hệ 10 lần 1) của tất cả
-- các sinh viên có đăng ký học tập trong học kỳ 2 năm học 2013-2014.
-- Điểm trung bình học kỳ tính theo công thức:
--		Điểm TB học kỳ = SUM(Điểm hệ 10 * Số tín chỉ)/SUM(Số tín chỉ)
---------------------------------------------------------------------------------------------------------------

SELECT sv.MaSinhVien,sv.HoDem,sv.Ten,
(CASE WHEN sv.MaSinhVien = sv.MaSinhVien THEN SUM(h.SoTinChi) ELSE NULL END) AS Tongtinchi,
(CASE WHEN sv.MaSinhVien = sv.MaSinhVien THEN SUM(ld.DiemHe10 *h.SoTinChi)/SUM(H.SoTinChi) ELSE NULL END) AS DiemTBHK
FROM SinhVien AS sv 
	 JOIN LopHocPhan_SinhVien AS ls ON sv.MaSinhVien = ls.MaSinhVien
	 JOIN LopHocPhan AS l ON ls.MaLopHocPhan = l.MaLopHocPhan
	 JOIN HocPhan AS h ON l.MaHocPhan = h.MaHocPhan
	 JOIN LopHocPhan_DiemThi AS ld ON ls.MaLopHocPhan = ld.MaLopHocPhan AND ls.MaSinhVien = ld.MaSinhVien
WHERE l.MaHocKy= '2013-2014.2'
GROUP BY sv.MaSinhVien,sv.HoDem,sv.Ten
---------------------------------------------------------------------------------------------------------------
-- 5. Nhà trường đề nghị lập danh sách khen thưởng cho các sinh viên học giỏi của các khóa trong học kỳ 2
-- năm học 2013-2014. Hãy giúp Nhà trường lập danh sách các sinh viên học giỏi nhất của mỗi khóa trong học kỳ này. 
-- biết rằng, việc tính điểm trung bình để xét khen thưởng theo qui định sau:
--		+ Chỉ lấy điểm thi lần 1 của các học phần trong học kỳ 
--		+ Sinh viên được khen thưởng của mỗi khóa là sinh viên có điểm trung bình cao nhất trong
--		  số các sinh viên học cùng khóa. 
--		+ Tổng số tín chỉ mà sinh viên đã học trong học kỳ tối thiểu phải 12 tín chỉ
---------------------------------------------------------------------------------------------------------------
