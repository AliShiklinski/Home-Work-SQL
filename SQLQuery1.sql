
CREATE TABLE Authors (
    Id INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Surname VARCHAR(100) NOT NULL
);

 CREATE TABLE Books (
    Id INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    AuthorId INT,
    PageCount INT NOT NULL CHECK (PageCount > 0),
    CostPrice DECIMAL(10, 2),
    SalePrice DECIMAL(10, 2),
    FOREIGN KEY (AuthorId) REFERENCES Authors(Id)
);

CREATE TABLE Tags (
    Id INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE BooksTags (
    BookId INT,
    TagId INT,
    PRIMARY KEY (BookId, TagId),
    FOREIGN KEY (BookId) REFERENCES Books(Id),
    FOREIGN KEY (TagId) REFERENCES Tags(Id)
);
INSERT INTO Authors (Id, Name, Surname) VALUES
(1, 'Ceyn', 'Ostin'),
(2, 'Lev', 'Tolstoy');

INSERT INTO Books (Id, Name, AuthorId, PageCount, CostPrice, SalePrice) VALUES
(1, 'Book One', 1, 300, 15.00, 20.00),
(2, 'Book Two', 2, 150, 10.00, 15.00);

INSERT INTO Tags (Id, Name) VALUES
(1, 'BestSeller'),
(2, 'Featured'),
(3, 'New');

INSERT INTO BooksTags (BookId, TagId) VALUES
(1, 1),
(1, 2),
(2, 3);

CREATE VIEW BookDetails 
SELECT 
    B.Id,
    CONCAT(A.Name, ' ', A.Surname) AS AuthorFullName,
    B.Name AS BookName,
    B.SalePrice AS BookPrice,
    B.PageCount,
    T.Name AS TagName
FROM 
    Books B
JOIN 
    Authors A ON B.AuthorId = A.Id
JOIN 
    BooksTags BT ON B.Id = BT.BookId
JOIN 
    Tags T ON BT.TagId = T.Id;

	SELECT * FROM BookDetails;

