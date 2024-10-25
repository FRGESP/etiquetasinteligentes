CREATE DATABASE Etiquetas
GO

USE Etiquetas
GO

CREATE TABLE Pais(
    IdPais INT IDENTITY PRIMARY KEY,
    Pais VARCHAR(50)
)
GO

CREATE TABLE Estado(
    IdEstado INT IDENTITY PRIMARY KEY,
    Estado VARCHAR(50),
    IdPais INT FOREIGN KEY REFERENCES Pais(IdPais)
)
GO
CREATE TABLE Municipio(
    IdMunicipio INT IDENTITY PRIMARY KEY,
    Municipio VARCHAR(50),
    IdEstado INT FOREIGN KEY REFERENCES Estado(IdEstado)
)
GO

CREATE TABLE Direccion(
    IdDireccion INT IDENTITY PRIMARY KEY,
    Direccion VARCHAR(MAX),
    IdMunicipio INT FOREIGN KEY REFERENCES Municipio(IdMunicipio)
)
GO

CREATE TABLE Viñedo(
    IdViñedo    INT NOT NULL IDENTITY,
    Nombre      VARCHAR(MAX) ,
    IdDireccion INT FOREIGN KEY REFERENCES Direccion(IdDireccion),
    Descripcion varchar(max),
    Liga        VARCHAR(MAX),
    CONSTRAINT PK_Viñedo PRIMARY KEY(IdViñedo)
)
GO

CREATE TABLE Uva(
IdUva INT NOT NULL IDENTITY,
Uva VARCHAR(256) NOT NULL,
Color VARCHAR(256) NOT NULL,
CONSTRAINT PK_UVA PRIMARY KEY(IdUva)
);
GO

CREATE TABLE Categoria(
IdCategoria INT NOT NULL IDENTITY,
Categoria VARCHAR(256) NOT NULL UNIQUE,
CONSTRAINT PK_Categoria PRIMARY KEY(IdCategoria),
);
GO

CREATE TABLE Cata(
IdCata INT NOT NULL IDENTITY,
Vista varchar(max) NOT NULL,
Boca varchar(max) NOT NULL,
Nariz varchar(max) NOT NULL,
Maridaje varchar(max) NOT NULL,
CONSTRAINT PK_Cata PRIMARY KEY(IdCata),
);
GO

CREATE TABLE Vino(
IdVino int not null IDENTITY,
IdViñedo INT NOT NULL,
IdCategoria INT NOT NULL,
IdCata INT NOT NULL UNIQUE,
Vino VARCHAR(MAX) NOT NULL,
Crianza VARCHAR(MAX),
Añejamiento VARCHAR(MAX),
Temperatura VARCHAR(MAX),
CONSTRAINT PK_Vinos PRIMARY KEY(IdVino),
CONSTRAINT FK_VinosToViñedos FOREIGN KEY(IdViñedo) REFERENCES Viñedo(IdViñedo) ON DELETE CASCADE,
CONSTRAINT FK_VinosToCategoria FOREIGN KEY(IdCategoria) REFERENCES Categoria(IdCategoria) ON DELETE CASCADE,
CONSTRAINT FK_VinosToCata FOREIGN KEY(IdCata) REFERENCES Cata(IdCata) ON DELETE CASCADE
);
GO

CREATE TABLE VinoUva(
IdVino INT NOT NULL,
IdUva INT NOT NULL,
CONSTRAINT PK_VinoUva PRIMARY KEY(IdVino,IdUva),
CONSTRAINT FK_VinoUvaToVino FOREIGN KEY(IdVino) REFERENCES Vino(IdVino) ON DELETE CASCADE,
CONSTRAINT FK_VinoUvaToUva FOREIGN KEY(IdUva) REFERENCES Uva(IdUva) ON DELETE CASCADE
);
GO

--- Llenando con infromación del excel ---

INSERT INTO Pais values('Mexico');
INSERT INTO Estado VALUES ('Guanajuato',1);
INSERT INTO Municipio (Municipio,IdEstado) SELECT M.Municipio, E.IdEstado FROM MunicipioExcel AS M inner join Estado AS E on M.IdEstado = E.IdEstado
INSERT INTO Direccion (Direccion, IdMunicipio) SELECT R.Calle, R.IdMunicipio FROM RegionExcel AS R
INSERT INTO Viñedo (Nombre, IdDireccion, Descripcion, Liga) SELECT V.Nombre, V.IDRegión, V.Información, V.URL FROM VinedoExcel AS V
INSERT INTO Cata (Vista, Boca, Nariz, Maridaje) SELECT V.Vista, V.Boca, V.Nariz, V.Maridaje FROM VinoExcel AS V WHERE IDVino IS NOT NULL
INSERT INTO Categoria (Categoria) SELECT C.Categoria FROM CategoriasExcel AS C
INSERT INTO Vino (IdViñedo,IdCategoria, IdCata, Vino, Crianza, Añejamiento, Temperatura) SELECT V2.IdViñedo, C.IdCategoria, Ca.IdCata, V.Vino, V.Crianza, V.Añejamiento, V.Temperatura FROM VinoExcel AS V INNER JOIN Categoria C on V.IDCategoria = C.IdCategoria INNER JOIN Cata AS Ca ON V.IDVino = Ca.IdCata INNER JOIN Viñedo V2 on V.IDViñedo = V2.IdViñedo
INSERT INTO Uva (Uva, Color) SELECT U.Uva, U.Color FROM UvaExcel AS U
INSERT INTO VinoUva (IdVino, IdUva) SELECT V.IdVino, V.IdUva FROM VinoUvaExcel AS V
