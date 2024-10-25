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
    Direccion VARCHAR(100),
    IdMunicipio INT FOREIGN KEY REFERENCES Municipio(IdMunicipio)
)
GO

CREATE TABLE Viñedos(
    IdViñedo INT ,
    Nombre  VARCHAR(50) ,
    IdDireccion INT FOREIGN KEY REFERENCES Direccion(IdDireccion),
    Descripcion VARCHAR(500) ,
    Liga VARCHAR(50),
    CONSTRAINT PK_Viñedo PRIMARY KEY(IdViñedo)
)
GO

 