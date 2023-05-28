create table CongViec
(
	MaCongViec nvarchar(50) not null,
	TenCongViec nvarchar(255) not null,
	NgayBatDau date not null,
	TongGioThucHien int null
	constraint PK_MaCongViec primary key(MaCongViec)
)
go
create table PhanCongThucHien
(
	MaCongViec nvarchar(50) not null,
	MaNhanVien nvarchar(50) not null,
	SoGioThucHien int not null,
	constraint PK_MaCongViec_MaNhanVien primary key(MaCongViec,MaNhanVien)
)
go
create table NhanVien
(
	MaNhanVien nvarchar(50) not null,
	HoTen nvarchar(255) not null,
	GioiTinh nvarchar(10) not null,
	DiDong nvarchar(50) not null,
	constraint PK_MaNhanVien primary key(MaNhanVien)
)
go
alter table PhanCongThucHien
add constraint FK_PhanCongThucHien_CongViec foreign key(MaCongViec)
	references CongViec(MaCongViec)
	on update cascade
	on delete no action
go
alter table PhanCongThucHien
add constraint FK_PhanCongThucHien_NhanVien foreign key(MaNhanVien)
	references NhanVien(MaNhanVien)
	on update cascade
	on delete no action
go

insert into CongViec(MaCongViec,TenCongViec,NgayBatDau)
values(N'CV01',N'Phân tích thiết kế','2023-01-01'),
	  (N'CV02',N'Thiết kế CSDL','2023-02-01'),
	  (N'CV03',N'Lập trình','2023-02-15'),
	  (N'CV04',N'Kiểm thử','2023-05-01'),
      (N'CV05',N'Cài đặt - triển khai','2023-06-10')
go
insert into NhanVien(MaNhanVien,HoTen,GioiTinh,DiDong)
values(N'NV01',N'Nguyễn Văn Hùng',N'Nam',N'0914000986'),
	  (N'NV02',N'Lê Hữu Toàn',N'Nam',N'0914222974'),
	  (N'NV03',N'Nguyễn Thị Hoa',N'Nữ',N'0914054116'),
	  (N'NV04',N'Trần Văn Hải',N'Nam',N'0935222016'),
	  (N'NV05',N'Hoàng Thị Hà',N'Nữ',N'0984111341'),
	  (N'NV06',N'Mai Quang Linh',N'Nam',N'0983023491')
go
insert into PhanCongThucHien(MaCongViec,MaNhanVien,SoGioThucHien)
values(N'CV01',N'NV04',100),
	  (N'CV01',N'NV05',50),
	  (N'CV02',N'NV01',80),
	  (N'CV02',N'NV04',80),
	  (N'CV03',N'NV02',200),
	  (N'CV03',N'NV03',150),
	  (N'CV03',N'NV05',150),
	  (N'CV04',N'NV01',50),
	  (N'CV05',N'NV04',70)
go

--3.
select nv.MaNhanVien,nv.HoTen,nv.GioiTinh,nv.DiDong
from NhanVien as nv
where nv.HoTen like N'Nguyễn%' and nv.DiDong like N'%6'
--4.
select cv.MaCongViec,cv.TenCongViec,cv.NgayBatDau
from CongViec as cv
where year(cv.NgayBatDau) = 2023 and month(cv.NgayBatDau)= 2
--5.
select cv.MaCongViec,cv.TenCongViec,cv.NgayBatDau
from CongViec as cv
where cv.NgayBatDau >= N'2020-01-01' and cv.NgayBatDau <= N'2023-4-30'
order by cv.NgayBatDau desc
--6.
select nv.MaNhanVien,nv.HoTen,nv.DiDong,pc.SoGioThucHien,cv.TenCongViec
from NhanVien as nv
	join PhanCongThucHien as pc on nv.MaNhanVien=pc.MaNhanVien
	join CongViec as cv on pc.MaCongViec=cv.MaCongViec
where cv.TenCongViec=N'Lập trình'
--7.
select sum(case when nv.GioiTinh=N'Nam' then 1 else 0 end) as N'Số sv Nam',
sum(case when nv.GioiTinh=N'Nữ' then 1 else 0 end) as N'Số sv Nữ'
from NhanVien as nv
where nv.DiDong like N'091%'
--8.
select nv.MaNhanVien,nv.HoTen,nv.DiDong,sum(pc.SoGioThucHien) as N'Tong so gio thuc hien'
from NhanVien as nv
	left join PhanCongThucHien as pc on nv.MaNhanVien=pc.MaNhanVien
group by
 nv.MaNhanVien,nv.HoTen,nv.DiDong
 --9.
 select nv.MaNhanVien,nv.HoTen,nv.DiDong
 from NhanVien as nv 
 join PhanCongThucHien as pc on nv.MaNhanVien=pc.MaNhanVien 
where nv.MaNhanVien not in( select pc.MaNhanVien
							from PhanCongThucHien as pc
							where pc.MaCongViec=N'CV01'
						)
--10.
select nv.MaNhanVien,nv.HoTen,sum(pc.SoGioThucHien) as N'Tong so gio thuc hien'
from NhanVien as nv 
	left join PhanCongThucHien as pc on nv.MaNhanVien=pc.MaNhanVien
group by nv.MaNhanVien,nv.HoTen
having sum(pc.SoGioThucHien) >= all( select isnull (sum(pc.SoGioThucHien),0)
									from NhanVien as nv1
									left join PhanCongThucHien as pc on nv1.MaNhanVien=pc.MaNhanVien
									where nv.MaNhanVien=nv1.MaNhanVien
									group by nv1.MaNhanVien,nv1.HoTen
									)
--11.
update PhanCongThucHien
set SoGioThucHien=SoGioThucHien*2
from PhanCongThucHien as pc 
	join CongViec as cv on pc.MaCongViec=cv.MaCongViec
where cv.TenCongViec=N'Lập trình'
--12.
alter table CongViec
add TongGioThucHien int null
go
select sum(pc.SoGioThucHien) as N'Tong so gio thuc hien'
from CongViec as cv 
	join PhanCongThucHien as pc on cv.MaCongViec=pc.MaCongViec
update CongViec
set
