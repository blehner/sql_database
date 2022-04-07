
use Karbantarto01_DB

-- korabbi tablak eldobva

GO
DROP TABLE IF EXISTS occupations
DROP TABLE IF EXISTS users
DROP TABLE IF EXISTS roles
DROP TABLE IF EXISTS assets
DROP TABLE IF EXISTS mainCategory
DROP TABLE IF EXISTS subCategory
DROP TABLE IF EXISTS operations
GO

--User felvétele az alapvető belépéshez

-- TABLES

-- a rendszerben betöltött feladatok

GO
CREATE TABLE roles
(
id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
roleName VARCHAR(50) NOT NULL
)
GO

-- végzettségek (foglalkozás)

GO
CREATE TABLE occupations
(
	id INT IDENTITY NOT NULL PRIMARY KEY,
	occupationName VARCHAR(50) NOT NULL,
	occupationDescrition TEXT
)
GO



--felhasznalok

GO
CREATE TABLE users
(
	id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	username VARCHAR(50) NOT NULL, --belépéshez
	fullName VARCHAR(50) NOT NULL,
	roleId INT NOT NULL, -- a belépéshez itt tárolom
	occupationId INT,
	password VARCHAR(50) NOT NULL,
	token VARCHAR(50),--belépéshez itt lesz
	CONSTRAINT FK_OccupationId FOREIGN KEY (occupationId) REFERENCES occupations(id)
)
GO

use Karbantarto01_DB

-- eszkozok

CREATE TABLE assets -- !!!! Itt a foreign key-eket nem tudtam valamiert bevezetni, de mindegy
(
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	name VARCHAR(50) NOT NULL,
	location VARCHAR(50) NOT NULL,
	assetsMainCategory INT NOT NULL,
	assetsSubCategory INT NOT NULL,
	--CONSTRAINT FK_MAINCATEGORY2 FOREIGN KEY (assetsMainCategory) REFERENCES mainCategory(id), -- MAIN CATEGORY
	--CONSTRAINT FK_SUBCATEGORY2 FOREIGN KEY (assetsSubCategory) REFERENCES subCategory(id)-- SUBCATEGORY
)

-- karbantartas fokategoria

GO
CREATE TABLE mainCategory 
(
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	mainCategoryName VARCHAR(50) NOT NULL,
	mainCategoryWorkMinutes INT NOT NULL,
	mainCategoryOccupation INT NOT NULL,
	mainCategoryOpId INT,
	CONSTRAINT FK_MAINCATEGORYROLE FOREIGN KEY (mainCategoryOccupation) REFERENCES occupations(id)
)
GO

-- karbantartas alkategoria

GO
CREATE TABLE subCategory 
(
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	subCategoryName VARCHAR(50) NOT NULL,
	subCategoryLevel INT NOT NULL,
	subMainId INT NOT NULL,
	subCategoryWorkMinutes INT,
	subCategoryOccupation INT NOT NULL,
	subCategoryOpId INT,
	CONSTRAINT FK_MAINCATEGORY FOREIGN KEY (subMainId) REFERENCES mainCategory(id),
	CONSTRAINT FK_SUBCATEGORYOCCUPATION FOREIGN KEY (subCategoryOccupation) REFERENCES occupations(id)
)
GO

-- tevekenysegek

GO
CREATE TABLE operations
(
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	opId INT NOT NULL,
	opName VARCHAR(50),
	opWorkMinutes INT NOT NULL
)
GO

-- egyebek

GO
select * from users
select * from occupations

select * from mainCategory

GO
-- 2022-04-07
-- Kiegeszites a token parameter miatt

GO
use Karbantarto01_DB

ALTER TABLE users
ADD token varchar(50)
GO

------2022-04-07-II-feladatsor--------------

use Karbantarto01_DB

GO
INSERT INTO occupations
VALUES
	(
		'root',
		'root felhasznalo, aki a teljes admin jogokkal rendelkezik'
	)
GO

GO
INSERT INTO roles
VALUES 
	(
		'root'
	)
GO

GO
INSERT INTO users
VALUES
	(
		'admin',
		'Lehner Bela',
		1, --role id
		1, --foglalkozas
		'admin123',
		'VALAMI'
	)
GO

DELETE FROM users WHERE id = 7

select * from occupations


select * from users



