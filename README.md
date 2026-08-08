# Tuần 5 - SQL Server căn bản và Stored Procedure

Thư mục này chứa các script SQL thực hành Tuần 5, chạy trên SQL Server (database `StudentManagement`).

## Cách chạy để test

1. Mở SSMS, kết nối vào SQL Server instance bất kỳ.
2. Chạy file `StudentManagement_FullScript.sql` trước tiên — file này tạo database `StudentManagement`, đầy đủ 4 bảng (`Classes`, `Students`, `Subjects`, `StudentGrades`), 1 view (`vw_StudentAcademicReport`), kèm sẵn dữ liệu mẫu.
3. Sau khi có database, mở lần lượt `SQLQuery_tuan5_ngay_3.sql` và `SQLQuery_tuan5_ngay_4.sql`, chạy từng câu lệnh để xem kết quả.

## Nội dung từng file

### `SQLQuery_tuan5_ngay_3.sql` — Truy vấn dữ liệu, DELETE, UPDATE, ORDER BY
- Lọc sinh viên theo email null/not null
- SELECT một số cột kèm điều kiện (`WHERE`, kết hợp `AND`)
- DELETE dữ liệu (có xử lý thứ tự xóa bảng con trước bảng cha do ràng buộc khóa ngoại)
- INSERT thêm lớp mới
- UPDATE thông tin sinh viên, cộng dồn số tín chỉ, đổi lớp, thay thế chuỗi trong email (`REPLACE`)
- ORDER BY: sắp xếp theo tên, theo tín chỉ, sắp xếp nhiều cột (giới tính rồi đến ngày sinh)

### `SQLQuery_tuan5_ngay_4.sql` — JOIN, GROUP BY, Aggregate functions, View
- Xem toàn bộ dữ liệu các bảng
- Thống kê điểm trung bình/cao nhất theo môn học (`LEFT JOIN` + `AVG`/`MAX`)
- Lọc sinh viên giỏi (điểm trung bình ≥ 8.0) bằng `GROUP BY` + `HAVING`
- Thống kê lớp có trên 1 sinh viên nữ
- Thống kê theo giới tính, theo lớp kết hợp giới tính
- Tạo View `vw_StudentAcademicReport` tổng hợp báo cáo học tập (số môn đã đăng ký + GPA)

## Deliverable
- `StudentManagement_FullScript.sql` — script setup database đầy đủ (schema + data)
- `SQLQuery_tuan5_ngay_3.sql`, `SQLQuery_tuan5_ngay_4.sql` — các câu lệnh test/thực hành theo ngày
