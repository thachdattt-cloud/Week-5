
--lấy danh sách sinh viên có email null --
select * from Students where email is null

--lấy danh sách sinh viên có email ko null --
select * from Students where email is not null

-- lấy 1 số cột của Students
select StudentCode,FullName,Email
from Students 

-- lấy 1 số cột của Students có điều kiện
select StudentCode,FullName,Email,Gender,BirthDate
from Students 
where Gender = 1 and email is not null and BirthDate >= '2003-05-05'

--delete--
delete from Students 
where Email is null


--xóa dlieu của bảng cha--(xoa bảng con trc vì có constraints)
delete from Students 
where ClassID=3

delete from Classes
where ClassID =3

select *from Classes

insert into Classes (ClassCode,ClassName) values
('cntt03',N'công nghệ thông tin 3');

--update----
update Students 
set FullName =N'Nguyễn Hữu Quang',
    BirthDate='2005-02-09'
where StudentID=1

--select--
select *from Subjects
select * from Classes
select * from Students
--tăng số tin chỉ của cs len 1--


update Subjects
set Credits = Credits +1
where SubjectCode='Cs101'
-- chuyển sinh viên sv02 sang lớp id=4

update Students 
set ClassID=4
where StudentCode='SV02'
-- thay thể đuôi email của tát cả sinh vien nam--
update Students
set email = REPLACE(email,'@gmail.com','@uneti.com')

--orderby---
--sắp xếp tăng dân theo tên-----
select *from Students
order by FullName asc
--sap xep tin chi giam dan---
select *from Subjects
order by Credits desc

-- Sắp xếp theo Giới tính (Nữ trước, Nam sau), trong cùng giới tính thì xếp người sinh sau lên trước
select *from Students
order by Gender asc , BirthDate desc 