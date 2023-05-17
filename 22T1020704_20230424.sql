--BÀI 5: BỔ SUNG, CẬP NHẬT VÀ XOÁ DỮ LIỆU
--Nội dung : 3 lệnh
 --INSERT : Bổ sung dữ liệu
 --UPDATE : Cập nhật(thay đổi/sửa) dữ liệu
 --DELETE : Xoá dữ liệu

--5.1 BỔ SUNG DỮ LIỆU ( Lệnh INSERT)
--Sử dụng lệnh INSERT để thêm(bổ sung) dữ liệu vào bảng : 2 cách
 --Cách 1 : Bổ sung từng dòng dữ liệu
--Cú pháp :
	--INSERT INTO Bảng(Danh_sách_cột)
	---VALUES(Danh_sách_giá_trị)
---Trong đó :
-- Danh sách cột/giá trị phân cách nhau bởi dấu phẩy
-- Giá trị chuỗi,ngày,giờ viết trong cặp dấu nháy đơn.
VD: --Bổ sung cho bảng MONHOC một môn học có mã là TI-099, tên là'Lập trình web' có số đơn vị học trình là 3.
SELECT * FROM MONHOC
INSERT INTO MONHOC(MAMONHOC,TENMONHOC,SODVHT)
VALUES('TI-009',N'Lập trình web', 3)
-- Lưu ý : Trong SQL Server, có thể dùng 1 lệnh INSERT để bổ sung nhiều dòng dữ liệu(tối đa 1000 dòng).
VD: --Bổ sung thêm 2 môn học
INSERT INTO MONHOC(MAMONHOC,TENMONHOC,SODVHT)
VALUES ('TI-010',N'Lập trình Mobile',3),
	   ('TI-011',N'Thiết kế mạch',4)

--Cách 2 : Bổ sung dữ liệu cho bảng từ kết quả của 1 câu lệnh SELECT (thực hiện 1 câu lệnh SELECT và đưa 
--kết quả truy vấn vào lưu trong 1 bảng).
--Cú pháp:
	--INSERT INTO Bảng(Danh_sách_cột)
	--SELECT ...
	--FROM ...
 --VD: Lập bảng điểm môn học có mã 'TI-009' cho các sv của lớp có mã là 'C24102'
 --(Khi lập bảng điểm, điểm lần 1 bằng 0 và điểm lần 2 là NULL)

 SELECT *
 FROM SINHVIEN AS sv
	JOIN DIEMTHI AS d ON sv.MASV = d.MASV
WHERE sv.MALOP = 'C24102' AND d.MAMONHOC= 'TI-009'
--Lập bảng điểm:

INSERT INTO DIEMTHI(MAMONHOC,MASV,DIEMLAN1,DIEMLAN2)
SELECT 'TI-009',sv.MASV,0,NULL
FROM SINHVIEN AS sv
WHERE sv.MALOP='C24102'

--Lập bảng điểm môn 'Lập trình Mobile' và 'Thiết kế mạch' cho sv của lớp 'Tin K24'
INSERT INTO DIEMTHI(MAMONHOC,MASV,DIEMLAN1,DIEMLAN2)
	SELECT m.MAMONHOC,sv.MASV,0,NULL
	FROM LOP AS l
		JOIN SINHVIEN AS sv ON l.MALOP = sv.MALOP
		CROSS JOIN MONHOC AS m
	WHERE m.TENMONHOC IN (N'Lập trình Mobile',N'Thiết kế mạch')
	AND l.TENLOP = 'Tin K24'
--Một số lưu ý khi bổ sung dữ liệu vào bảng:
-- Dữ liệu bổ sung vào bảng phải thoả mãn các ràng buộc(constraint) tồn tại trên bảng:
	-- Khoá chính(primary key)/khoá phụ(unique)
	-- Khoá ngoài(foreign key):dữ liệu nhập vào bảng tham chiếu(phụ/con) thì phải tồn tại trong bảng được tham chiếu(chính/cha)
	-- Các ràng buộc kiểm tra tính hợp lệ của dữ liệu(CHECK)
--Nếu 1 cột mà không được nhập dữ liệu thì:
	--Nếu cột có qui định giá trị mặc định thì nhận giá trị mặc định
	--Nếu cột cho phép nhận giá trị NULL thì nhận giá trị NULL
	--Nếu cột không có giá trị mặc định và không cho phép NULL thì sẽ gặp lỗi.
	--(Khi bổ sung dữ liệu,có thể bỏ qua các cột mà có giá trị mặc định hoặc cho phép nhận giá trị NULL)
-- Không được nhập dữ liệu cho các cột:
	--Cột có tính chất IDENTITY
	--Cột có tính toán từ một biểu thức

CREATE TABLE TEST
(
	A int IDENTITY(1,1),
	B int NOT NULL,
	C AS B*2
)
INSERT INTO TEST(B)
VALUES (100),
	   (150),
	   (200);
SELECT * FROM TEST;

INSERT INTO TEST(A,B,C)
VALUES(4,500,1000); --=> Lỗi

--5.2 CẬP NHẬT DỮ LIỆU( lệnh UPDATE)
--Có 2 cách dùng:
--Cách 1: Cập nhật dữ liệu cho 1 bảng và trong câu lệnh không liên quan đến việc nối với các bảng khác.
--Cú pháp:
	--UPDATE Bảng
	--SET Tên_cột_1 = Biểu_thức_1,

--VD: Thay tên môn học có mã 'TI-009' là 'Lập trình ứng dụng web' và số dvht là 4.
SELECT * FROM MONHOC
UPDATE MONHOC
SET TENMONHOC=N'Lập trình ứng dụng web',
SODVHT = 4
WHERE MAMONHOC='TI-009'

--Đổi số đơn vị học trình của môn 'TI-010' bằng với số đơn vị học trình của môn 'TI-009'
UPDATE MONHOC
SET SODVHT=(SELECT SODVHT
			FROM MONHOC
			WHERE MAMONHOC='TI-009')
WHERE MAMONHOC='TI-010'
--Cách 2: Cập nhật dữ liệu cho 1 bảng và trong câu lệnh có sử dụng đến phép nối(liên quan đến các bảng khác)
--Cú pháp:
	--UPDATE Bảng/Bí_danh_bảng
	--SET Tên_cột_1 = Biểu_thức_1,
	--...
		--Tên_cột_N = Biểu_thức_N
	--FROM Phép_nối
	--WHERE Điều_kiện
--VD: Cho điểm môn'Lập trình Mobile' của sv lớp 'Tin K24' theo qui tắc sau:
	--Sinh viên nữ: điểm thi lần 1 là 10 điểm
	--Sinh viên nam: điểm thi lần 1 là 2 điểm và điểm thi lần 2 là 8 điểm
UPDATE d 
SET d.DIEMLAN1 = CASE
					WHEN sv.GIOITINH = 0 THEN 10
					ELSE 2
				 END,
	d.DIEMLAN2 = CASE
					WHEN sv.GIOITINH = 0 THEN NULL
					ELSE 8
				END
--SELECT *
FROM LOP AS l
	JOIN SINHVIEN AS sv ON l.MALOP=sv.MALOP
	JOIN DIEMTHI AS d ON sv.MASV=d.MASV
	JOIN MONHOC AS m ON d.MAMONHOC=m.MAMONHOC
WHERE m.TENMONHOC=N'Lập trình Mobile'
AND l.TENLOP=N'Tin K24'
--Lưu ý :
	--Câu lệnh UPDATE mà không có WHERE =>Toàn bộ dữ liệu được cập nhật(nguy hiểm)
	--Cẩn thận khi thực hiện lệnh UPDATE

--5.3 XOÁ DỮ LIỆU (lệnh DELETE)
--Cách 1: Xoá dữ liệu trong 1 bảng và không liên quan gì đến các bảng khác(khôbg dùng phép nối)
--Cú pháp:
	--DELETE FROM Bảng
	--WHERE Điều_kiện
--VD: Xoá môn học có mã 'TI-012'
	DELETE FROM MONHOC
	WHERE MAMONHOC = 'TI-012'
--Cách 2: Xoá dữ liệu trong 1 bảng và trong câu lệnh có dùng đến phép nói(liên quan nhiều bảng)
--Cú pháp:
	--DELETE FROM Bảng/Bí_danh_bảng
	--FROM Phép_nối
	--WHERE Điều_kiện
--VD: Xoá điểm thi môn 'Lập trình Mobile' của lớp 'Tin K24'
DELETE FROM d
--SELECT *
FROM LOP AS l
	JOIN SINHVIEN AS sv ON l.MALOP=sv.MALOP
	JOIN DIEMTHI AS d ON sv.MASV=d.MASV
	JOIN MONHOC AS m ON d.MAMONHOC=m.MAMONHOC
WHERE m.TENMONHOC=N'Lập trình Mobile'
AND l.TENLOP=N'Tin K24'
--Lưu ý : 
	--Lệnh DELETE không có WHERE sẽ xoá toàn bộ dữ liệu
	--Tuyệt đói cẩn thận khi dùng lệnh DELETE