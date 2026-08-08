-- =================================================================
-- 1. TRUY VẤN XEM TOÀN BỘ DỮ LIỆU CỦA CÁC BẢNG
-- =================================================================
SELECT * FROM Students;
SELECT * FROM Subjects;
SELECT * FROM Classes;
SELECT * FROM StudentGrades;


-- =================================================================
-- 2. THỐNG KÊ ĐIỂM TRUNG BÌNH VÀ ĐIỂM CAO NHẤT THEO TỪNG MÔN HỌC
-- (Hiển thị tất cả các môn học, kể cả môn chưa có sinh viên có điểm)
-- =================================================================
SELECT 
    Sub.SubjectCode,
    Sub.SubjectName,
    AVG(G.Mark) AS AvgMark,
    MAX(G.Mark) AS MaxMark
FROM Subjects Sub
LEFT JOIN StudentGrades G ON Sub.SubjectID = G.SubjectID
GROUP BY Sub.SubjectCode, Sub.SubjectName;


-- =================================================================
-- 3. DANH SÁCH SINH VIÊN CÓ ĐIỂM TRUNG BÌNH CỘNG TỪ 8.0 TRỞ LÊN (HỌC SINH GIỎI)
-- =================================================================
SELECT 
    S.StudentID, 
    S.FullName, 
    AVG(G.Mark) AS AverageMark
FROM Students S
JOIN StudentGrades G ON S.StudentID = G.StudentID
GROUP BY S.StudentID, S.FullName
HAVING AVG(G.Mark) >= 8.0;


-- =================================================================
-- 4. THỐNG KÊ CÁC LỚP HỌC CÓ TRÊN 1 SINH VIÊN NỮ (Gender = 0)
-- =================================================================
SELECT 
    C.ClassName, 
    COUNT(S.StudentID) AS SoLuongSVNu
FROM Classes C
INNER JOIN Students S ON C.ClassID = S.ClassID
WHERE S.Gender = 0                    
GROUP BY C.ClassName                    
HAVING COUNT(S.StudentID) > 1;     


-- =================================================================
-- 5. THỐNG KÊ SỐ LƯỢNG VÀ TÊN DÒNG ĐẦU THEO BẢNG CHỮ CÁI PHÂN THEO GIỚI TÍNH
-- =================================================================
SELECT 
    Gender, 
    MIN(FullName) AS TenDauTien, 
    COUNT(StudentID) AS SoLuong
FROM Students
GROUP BY Gender;


-- =================================================================
-- 6. THỐNG KÊ SỐ LƯỢNG SINH VIÊN CHIA CHI TIẾT THEO TỪNG LỚP VÀ TỪNG GIỚI TÍNH
-- =================================================================
SELECT 
    C.ClassName,
    S.Gender,
    COUNT(S.StudentID) AS SoLuong
FROM Students S
LEFT JOIN Classes C ON S.ClassID = S.ClassID
GROUP BY C.ClassName, S.Gender;


-- =================================================================
-- 7. TẠO VIEW TỔNG HỢP BÁO CÁO KẾT QUẢ HỌC TẬP (SỐ MÔN & ĐIỂM GPA) CỦA SINH VIÊN
-- =================================================================
GO
CREATE VIEW vw_StudentAcademicReport AS
SELECT 
    S.StudentID,
    S.StudentCode,
    S.FullName,
    C.ClassName,
    COUNT(G.SubjectID) AS TotalRegisteredSubjects,
    ROUND(AVG(G.Mark), 2) AS GPA
FROM Students S
LEFT JOIN Classes C ON S.ClassID = C.ClassID
LEFT JOIN StudentGrades G ON S.StudentID = G.StudentID
GROUP BY S.StudentID, S.StudentCode, S.FullName, C.ClassName;
GO