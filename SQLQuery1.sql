


CREATE VIEW vw_Academies AS
SELECT *
FROM Academy;


CREATE VIEW vw_Groups AS
SELECT *
FROM Groups
WHERE IsDeleted = 0; 


CREATE VIEW vw_Students AS
SELECT *
FROM Students;

CREATE PROCEDURE GetGroupByName
    @GroupName NVARCHAR(100)
AS
BEGIN
    SELECT *
    FROM Groups
    WHERE Name = @GroupName
      AND IsDeleted = 0; 
END;

CREATE PROCEDURE GetStudentsOlderThanAge
    @Age INT
AS
BEGIN
    SELECT *
    FROM Students
    WHERE Age > @Age;
END;


CREATE PROCEDURE GetStudentsYoungerThanAge
    @Age INT
AS
BEGIN
    SELECT *
    FROM Students
    WHERE Age < @Age;
END;


CREATE TRIGGER trg_Students_Delete
ON Students
AFTER DELETE
AS
BEGIN
    INSERT INTO DeletedStudents (Id, Name, Surname, GroupId)
    SELECT Id, Name, Surname, GroupId
    FROM deleted;
END;

CREATE TRIGGER trg_Groups_Delete
ON Groups
INSTEAD OF DELETE
AS
BEGIN
    UPDATE Groups
    SET IsDeleted = 1
    WHERE Id IN (SELECT Id FROM deleted);
END;


CREATE TRIGGER trg_Students_Age_Update
ON Students
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE Students
    SET Adulthood = CASE
                        WHEN Age >= 18 THEN 1
                        ELSE 0
                    END
    WHERE Id IN (SELECT Id FROM inserted);
END;


CREATE FUNCTION GetTelebersByGroupId
    (@GroupId INT)
RETURNS TABLE
AS
RETURN
    (SELECT *
     FROM Students
     WHERE GroupId = @GroupId);
CREATE FUNCTION GetGroupsByAcademyId
    (@AcademyId INT)
RETURNS TABLE
AS
RETURN
    (SELECT *
     FROM Groups
     WHERE AcademyId = @AcademyId);
