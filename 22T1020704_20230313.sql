--1.CHo biết mã,họ tên, điểm thi của những sinh viên có điểm thi
--lần 1 môn 'Ngôn ngữ C' là cao nhất
--Cho biết mã,họ tên,điểm thi lần 1 môn'Ngôn ngữ C' của các sinh viên
-- với điều kiện điểm thi lần 1 =(điểm thi cao nhất của môn'NN C')
SELECT sv.MASV,sv.HODEM,sv.TEN,d.DIEMLAN1
FROM SINHVIEN AS sv
	JOIN DIEMTHI AS d ON sv.MASV = d.MASV
	JOIN MONHOC AS m ON d.MAMONHOC= m.MAMONHOC
WHERE m.TENMONHOC = N'Ngôn ngữ C'
	AND d.DIEMLAN1 >= ALL
	(
		SELECT d.DIEMLAN1
		FROM MONHOC AS m
			JOIN DIEMTHI AS d ON m.MAMONHOC= d.MAMONHOC
		WHERE m.TENMONHOC = N'Ngôn  ngữ C'
	)
--2.Hãy cho biết mã khoa,tên khoa và số lớp của những khoa mà có nhiều lớp nhất
SELECT k.MAKHOA,k.TENKHOA,COUNT(l.MALOP) AS SOLOP
FROM KHOA AS k
	JOIN LOP AS l ON k.MAKHOA = l.MAKHOA
GROUP BY k.MAKHOA,k.TENKHOA
HAVING COUNT(l.MALOP) >= ALL
(
	SELECT TOP(1) COUNT(MALOP)
	FROM LOP
	GROUP BY MAKHOA
	ORDER BY 1 DESC
)
--3.Những sinh viên nào có điểm thi lần 1 môn 'Ngôn ngũ C' thấp hơn mức điểm thi 
--trung bình của môn này
SELECT sv.MASV,sv.HODEM,sv.TEN,d.DIEMLAN1
FROM SINHVIEN AS sv
	JOIN DIEMTHI AS d ON sv.MASV= d.MASV
	JOIN MONHOC AS m ON d.MAMONHOC = m.MAMONHOC
WHERE m.TENMONHOC = N'Ngôn ngữ C' 
	AND d.DIEMLAN1 <
(
	SELECT AVG(DIEMLAN1) AS DIEMTRUNGBINH
	FROM MONHOC AS m JOIN DIEMTHI AS d ON m.MAMONHOC = d.MAMONHOC
	WHERE m.TENMONHOC=N'Ngôn ngữ C'
)
--4.Cho biết mã,họ tên,tên môn học và điểm thi lần 1 của những sinh viên có điểm
--cao nhất của môn học đó
SELECT sv.MASV,sv.HODEM,sv.TEN,m.TENMONHOC,d.DIEMLAN1
FROM SINHVIEN AS sv
	JOIN DIEMTHI AS d ON sv.MASV = d.MASV
	JOIN MONHOC AS m ON d.MAMONHOC= m.MAMONHOC
WHERE d.DIEMLAN1 >= ALL
( 
	SELECT DIEMLAN1
	FROM MONHOC AS m1 JOIN DIEMTHI AS d1 ON m1.MAMONHOC = d1.MAMONHOC
	WHERE m1.MAMONHOC = m.MAMONHOC
)
ORDER BY m.MAMONHOC
