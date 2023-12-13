
--1:N
-- Carrera 1:   N alumnos


create table carreras(

            id int identity(1,1),
			nombre varchar(50) not null,
			siglas varchar(10) null,
			primary key(id)
);



select * from carreras

insert into carreras values('ING. SISTEMAS COMPUTACIONALES', 'ISC')



create table alumnos(
 
           id int identity(1,1),
		   matricula char(7),
		   nombre varchar(30) not null,
		   apellidos varchar(30) not null,
		   idcarrera int not null,
		   primary key(id)

);
--Como ya teniamos elaborado la tabla alumnos y hemos agregado el campo idcarrera, tenemos que usar este nuevo comando:

alter table alumnos add idcarrera int not null;


select * from alumnos;


insert into alumnos values('1234567','juan','Perez', 7)  

alter table alumnos add constraint FK_alumno_carrera foreign key(idcarrera) references carreras(id);

delete from alumnos where id=1;

--el campo matricula no debe repetirse, entonces:

alter table alumnos add constraint UK_matricula unique(matricula);


--Relacionando la tabla carrera con la tabla alumnos: (1 : N)
alter table alumnos add constraint FK_alumno_carrera foreign key(idcarrera) references carreras(id);


--No dejara insertar este registro porque ya estan relacionadas las tablas carrera con alumnos.
insert into alumnos values('1234567','juan','Perez', 7)  
insert into alumnos values('1234567','juan','Perez', 1)
insert into alumnos values('1234570','Maria','Gonzales', 1)
insert into alumnos values('1234570','Pedro','Hernandez', 1)

select * from alumnos








--N:M

--Cada alumno cursa 1 o varias materias
--Cada materia es cursada por 1 o mas alumnos
--alumno N:M materias
--Hay que crear una tabla intermedia (tabla hija o tabla derivada) en una relacion de muchos a muchos.






create table materias(
              
            id int identity(1,1),
			nombre varchar(30) not null,
			nomb_corto varchar(5) null,
			primary key(id)

);

select * from materias;

insert into materias values('progr. orient, a objetos' , 'POO');

insert into materias values('matematicas', 'mat'); 








--Creando dicha tabla intermedia o derivada :

create table alumnos_materias(
          
         idalumno int,
		 idmateria int,
		 calif_final decimal(5,2),
		 primary key(idalumno,idmateria),

		 --como son dos claves foraneas necesito 2 restricciones:
		 --Esta es la primera llave foranea:
		 constraint FK_alumno_alumnos_materias Foreign Key(idalumno)
		                    references alumnos(id),
         --Esta es la segunda llave foranea:
		 constraint FK_materia_alumnos_materias Foreign Key(idmateria)
		                    references materias(id)

);

select * from alumnos_materias 

insert into alumnos_materias values(3,1,null);
insert into alumnos_materias values(3,2,null);
insert into alumnos_materias values(4,2,null);

select * from alumnos_materias



select * from alumnos_materias 


--Aqui hemos implementado la relacion muchos a muchos, la tabla intermedia esta conectada con sus tablas principales
--por medio de 2 relaciones 1 a N es decir
  
 -- N : I : M
-- N :  I (Relacion de 1 a N entre N (tabla alumnos) y tabla intermedia)  y    I : M (Relacion de 1 a N entre I(tabla intermedia) y M(tabla materias) ) 

-- alumno N:M materias --> alumno 1:N alumnos_materias , materias 1: N alumnos_materias



--insertando registros(filas)  en la tabla intermedia :    recordar que campos(columnas):












create table domicilios(
           id int identity(1,1),
		   calle varchar(30) not null,
		   numero varchar(8) null,
		   colonia varchar(40) not null,
		   primary key(id)

);


--RELACIONES 1 A 1 
--1:1
--Analizamos tablas Alumnos con domicilios

--En relaciones de 1 a 1 la llave primaria de 1 de esas tablas debe ser llave foranea en la otra tabla.
--El Id de la tabla alumno sera la llave foranea en la tabla domicilio


--Se está añadiendo una columna llamada idalumno a la tabla domicilios, que almacenará identificadores de alumnos.
alter table domicilios add idalumno int not null;



-- Se está estableciendo una relación de clave externa entre las tablas domicilios y alumnos, vinculando la nueva columna idalumno 
-- en domicilios a la columna id en alumnos. Esto generalmente se usa para garantizar la integridad referencial entre las tablas.
alter table domicilios add constraint FK_domicilio_alumno foreign key(idalumno) references alumnos(id); 


select * from domicilios;


insert into domicilios values('Hidalgo', '108-B', 'Revolucion', 3) 

insert into domicilios values('Morelos', '308', 'Independecia', 3) 



delete from domicilios where id=2;

--Agregamos una restriccion a la clave foranea
alter table domicilios add constraint UK_domicilio_alumno unique(idalumno);

insert into domicilios values('Morelos', '308', 'Independecia', 3) 