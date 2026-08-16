USE StudentManagement;
GO

-- 1. SP Create Student
CREATE OR ALTER PROCEDURE sp_CreateStudent
    @StudentCode VARCHAR(20),
    @FullName NVARCHAR(100),
    @Gender BIT,
    @BirthDate DATE,
    @Email VARCHAR(100),
    @ClassID INT,
    @NewStudentID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO Students (StudentCode, FullName, Gender, BirthDate, Email, ClassID)
    VALUES (@StudentCode, @FullName, @Gender, @BirthDate, @Email, @ClassID);
    
    SET @NewStudentID = SCOPE_IDENTITY();
END;
GO

-- 2. SP Get Student By ID
CREATE OR ALTER PROCEDURE sp_GetStudentByID
    @StudentID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT S.*, C.ClassName
    FROM Students S
    LEFT JOIN Classes C ON S.ClassID = C.ClassID
    WHERE S.StudentID = @StudentID;
END;
GO

-- 3. SP Update Student
CREATE OR ALTER PROCEDURE sp_UpdateStudent
    @StudentID INT,
    @FullName NVARCHAR(100),
    @Gender BIT,
    @BirthDate DATE,
    @Email VARCHAR(100),
    @ClassID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE Students
    SET FullName = @FullName,
        Gender = @Gender,
        BirthDate = @BirthDate,
        Email = @Email,
        ClassID = @ClassID
    WHERE StudentID = @StudentID;
END;
GO

-- 4. SP Delete Student
CREATE OR ALTER PROCEDURE sp_DeleteStudent
    @StudentID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DELETE FROM Students 
    WHERE StudentID = @StudentID;
END;
GO

-- 5. SP Get Students Paging
CREATE OR ALTER PROCEDURE sp_GetStudentsPaging
    @PageIndex INT = 1,               
    @PageSize INT = 10,                 
    @TotalRecords INT OUTPUT          
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT @TotalRecords = COUNT(*) FROM Students;
    
    SELECT 
        S.StudentID,
        S.StudentCode,
        S.FullName,
        S.Gender,
        S.BirthDate,
        S.Email,
        C.ClassName
    FROM Students S
    LEFT JOIN Classes C ON S.ClassID = C.ClassID
    ORDER BY S.StudentID DESC          
    OFFSET (@PageIndex - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END;
GO

--------------------------------------------------
-- SCRIPT TEST STORED PROCEDURES
--------------------------------------------------

-- Test 1: Create Student
DECLARE @InsertedID INT;
EXEC sp_CreateStudent 
    @StudentCode = 'SV999', 
    @FullName = N'Nguyễn Văn Quoc', 
    @Gender = 1, 
    @BirthDate = '2003-05-15', 
    @Email = 'nguyenvana@gmail.com', 
    @ClassID = 1, 
    @NewStudentID = @InsertedID OUTPUT;

SELECT @InsertedID AS [ID_Vua_Tao];
GO

-- Test 2: Get Paging
DECLARE @Total INT;
EXEC sp_GetStudentsPaging 
    @PageIndex = 1, 
    @PageSize = 2, 
    @TotalRecords = @Total OUTPUT;

SELECT @Total AS [Tong_So_Sinh_Vien];
GO