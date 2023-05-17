--1.Hãy cho biết thông tin về các ngành đào tạo và đơn vị quản lý ngành đó
	SELECT *
	FROM DONVI AS d
		JOIN HOCPHAN AS h ON d.MADONVI = h.MADONVI
		JOIN NGANHDAOTAO AS n ON h.MADONVI = n.MADONVI
--2.Hiển thị danh sách các học phần do 'Khoa Tiếng Anh chuyên ngành' phụ trách
SELECT h.MAHOCPHAN,h.TENHOCPHAN,h.SOTINCHI
FROM HOCPHAN AS h 
		LEFT JOIN DONVI AS d ON h.MADONVI = d.MADONVI
WHERE d.TENDONVI = N'Khoa Tiếng Anh chuyên ngành'
--3.Hãy cho biết danh sách các ngành đào tạo được tuyển sinh trong khoảng thời gian từ năm 2010
--đến năm 2014
SELECT n.MANGANH,n.TENNGANH
FROM NGANHDAOTAO AS n 
	JOIN KHOAHOC_NGANHDAOTAO AS kn ON	n.MANGANH = kn.MANGANH
	JOIN KHOAHOC AS k ON kn.MAKHOAHOC = k.MAKHOAHOC
WHERE k.NAMTUYENSINH >= 2010 AND k.NAMTUYENSINH <= 2014
--4. Hiển thị danh sách mã sinh viên, họ tên, giới tính, ngày sinh và nơi sinh của các sinh viên Ngành
--'Tiếng Anh' được tuyển sinh trong năm 2013. Dữ liệu hiển thị sắp xếp theo tên, họ
SELECT sv.MASINHVIEN,sv.HODEM,sv.TEN,sv.NGAYSINH,sv.GIOITINH,sv.NOISINH
FROM SINHVIEN AS sv 
	JOIN NGANHDAOTAO AS n ON sv.MANGANH = n.MANGANH
	JOIN KHOAHOC_NGANHDAOTAO AS kn ON	n.MANGANH = kn.MANGANH
	JOIN KHOAHOC AS k ON kn.MAKHOAHOC = k.MAKHOAHOC
WHERE n.TENNGANH = N'Tiếng Anh' AND k.NAMTUYENSINH = 2013
ORDER BY sv.HODEM,sv.TEN ASC
--5.In danh sách các sinh viên của lớp 'Đọc 5 - Nhóm 13' mở trong học kỳ 1 năm học 2014-2015.
--Sắp xếp danh sách theo họ, tên.
SELECT sv.MASINHVIEN ,sv.HODEM,sv.TEN
FROM SINHVIEN AS sv 
	JOIN LOPHOCPHAN_SINHVIEN AS ls ON sv.MASINHVIEN = ls.MASINHVIEN
	JOIN LOPHOCPHAN AS l ON ls.MALOPHOCPHAN = l.MALOPHOCPHAN
WHERE l.TENLOPHOCPHAN = N'Đọc 5- Nhóm 13' 
ORDER BY sv.HODEM,sv.TEN ASC
--6.Hãy cho biết điểm QTHT và điểm thi lần 1 của các sinh viên thuộc lớp học phần 'Nói 3 - Nhóm
--1' mở trong học kỳ 1 năm học 2012-2013.
SELECT ls.DIEMQTHT,ld.DIEMTHI,ld.LANTHI
FROM LOPHOCPHAN AS l 
	JOIN LOPHOCPHAN_SINHVIEN AS ls on l.MALOPHOCPHAN = ls.MALOPHOCPHAN
	JOIN LOPHOCPHAN_DIEMTHI AS ld ON ls.MALOPHOCPHAN = ld.MALOPHOCPHAN
WHERE l.TENLOPHOCPHAN = N'Nói 3- Nhóm 1' AND ld.LANTHI = 1
--7.Hãy cho biết mã sinh viên, họ tên, ngày sinh, nơi sinh, tên khóa học và tên ngành học của các
--sinh viên Nữ, sinh tại 'Quảng Trị' nhập học trong khoảng thời gian từ năm 2005 đến năm 2010
--(Lưu ý: năm nhập học căn cứ vào năm tuyển sinh của Khóa học)
SELECT sv.MASINHVIEN,sv.HODEM,sv.TEN,sv.NGAYSINH,sv.NOISINH,k.TENKHOAHOC,n.TENNGANH
FROM KHOAHOC AS k
	JOIN SINHVIEN AS sv ON k.MAKHOAHOC = sv.MAKHOAHOC
	JOIN NGANHDAOTAO AS n ON sv.MANGANH = n.MANGANH
WHERE sv.GIOITINH = N'FALSE'AND sv.NOISINH = N'Quảng Trị' AND  k.NAMTUYENSINH BETWEEN 2005 AND 2010
--8.Hiển thị danh sách mã sinh viên, họ tên, ngày sinh, nơi sinh, tên khóa học, tên ngành và năm
--nhập học của các sinh viên Nam thuộc họ 'Nguyễn Phúc' hoặc sinh viên Nữ thuộc họ 'Tôn Nữ'
SELECT sv.MASINHVIEN,sv.HODEM,sv.TEN,sv.NGAYSINH,sv.NOISINH,k.TENKHOAHOC,n.TENNGANH
FROM KHOAHOC AS k
	JOIN SINHVIEN AS sv ON k.MAKHOAHOC = sv.MAKHOAHOC
	JOIN NGANHDAOTAO AS n ON sv.MANGANH = n.MANGANH
WHERE sv.GIOITINH = N'TRUE'AND sv.HODEM = N'Nguyễn Phúc'
	OR sv.GIOITINH = N'FALSE' AND sv.HODEM = N'Tôn Nữ'
--9.Hiển thị mã lớp, tên lớp, mã học phần, số tín chỉ và tên đơn vị phụ trách chuyên môn của những
--lớp học phần được mở trong học kỳ 2 năm học 2013-2014.
SELECT l.MALOPHOCPHAN,l.TENLOPHOCPHAN,hp.MAHOCPHAN,hp.SOTINCHI,d.TENDONVI
FROM LOPHOCPHAN AS l 
	JOIN HOCPHAN AS hp ON l.MAHOCPHAN = hp.MAHOCPHAN
	JOIN DONVI AS d ON hp.MADONVI = d.MADONVI
--10.Hãy cho biết danh sách các lớp học phần mà 'Khoa Việt Nam học' phụ trách trong năm học
--2012-2013, sắp xếp theo học kỳ và mã học phần.
SELECT l.MALOPHOCPHAN,l.TENLOPHOCPHAN,d.TENDONVI
FROM LOPHOCPHAN AS l 
	JOIN HOCPHAN AS hp ON l.MAHOCPHAN = hp.MAHOCPHAN
	JOIN DONVI AS d ON hp.MADONVI = d.MADONVI
WHERE d.TENDONVI = N'Khoa Việt Nam học'









	
