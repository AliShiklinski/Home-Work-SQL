CREATE DATABASE Kitabxana

USE Kitabxana

CREATE TABLE Books (
    Id INT PRIMARY KEY,
    Name NVARCHAR(100),
    AuthorId INT,
    PageCount INT,
    FOREIGN KEY (AuthorId) REFERENCES Authors(Id)
);

CREATE VIEW BooksAuthorsView AS
SELECT 
    b.Id,
    b.Name,
    b.PageCount,
    a.Name + ' ' + a.Surname AS AuthorFullName
FROM 
    Books b
JOIN 
    Authors a ON b.AuthorId = a.Id;


	CREATE PROCEDURE SearchBooks 
    @SearchTerm NVARCHAR(100)
AS
BEGIN
    SELECT 
        b.Id,
        b.Name,
        b.PageCount,
        a.Name + ' ' + a.Surname AS AuthorFullName
    FROM 
        Books b
    JOIN 
        Authors a ON b.AuthorId = a.Id
    WHERE 
        b.Name LIKE '%' + @SearchTerm + '%'
        OR a.Name + ' ' + a.Surname LIKE '%' + @SearchTerm + '%';
END;


CREATE VIEW AuthorsSummaryView AS
SELECT 
    a.Id,
    a.Name + ' ' + a.Surname AS FullName,
    COUNT(b.Id) AS BooksCount,
    MAX(b.PageCount) AS MaxPageCount
FROM 
    Authors a
LEFT JOIN 
    Books b ON a.Id = b.AuthorId
GROUP BY 
    a.Id, a.Name, a.Surname;


