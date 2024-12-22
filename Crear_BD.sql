
-- CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE consultoria_proyectos_db;
GO

USE consultoria_proyectos_db;
GO

-- CREACIÓN DE LAS TABLAS Y CAMPOS

-- 1. Colaboradores
CREATE TABLE colaboradores(
	id INT PRIMARY KEY IDENTITY(1,1),
	nombre_completo VARCHAR(255) NOT NULL,
	correo_electronico VARCHAR(255) NULL,
	cargo VARCHAR(100) NOT NULL
);

-- 2. Clientes
CREATE TABLE clientes(
	id INT PRIMARY KEY IDENTITY(1,1),
	razon_social VARCHAR(255) NOT NULL,
	ruc VARCHAR(20) NOT NULL,
	correo_electronico VARCHAR(255) NOT NULL,
	direccion VARCHAR(255) NOT NULL,
	telefono VARCHAR(20) NOT NULL
);

-- 3. Proyectos
CREATE TABLE proyectos(
	id INT PRIMARY KEY IDENTITY(1,1),
	nombre_proyecto VARCHAR(MAX) NOT NULL,
	descripcion TEXT NULL,
	fecha_inicio DATE NOT NULL,
	fecha_fin DATE NOT NULL,
	estado VARCHAR(50) NOT NULL,
	id_cliente INT NOT NULL,
	CONSTRAINT FK_cliente_proyectos FOREIGN KEY (id_cliente) REFERENCES clientes(id)
);

-- 4. Participantes_Proyecto
CREATE TABLE participantes_proyecto(
	id INT PRIMARY KEY IDENTITY(1,1),
	id_colaborador INT NOT NULL,
	id_proyecto INT NOT NULL,
	fecha_incorporacion DATE NOT NULL,
	rol_proyecto VARCHAR(100) NOT NULL
	CONSTRAINT FK_colaborador_participantesProyectos  FOREIGN KEY (id_colaborador)
		REFERENCES colaboradores(id),
	CONSTRAINT FK_proyecto_participantesProyectos FOREIGN KEY (id_proyecto)
		REFERENCES proyectos(id)
);

-- 5. Tareas
CREATE TABLE tareas(
	id INT PRIMARY KEY IDENTITY(1,1),
	nombre_tarea VARCHAR(255) NOT NULL,
	fecha_inicio DATE NOT NULL,
	fecha_limite DATE NOT NULL,
	estado VARCHAR(50) NOT NULL
);

-- 6. Asignaciones_Tareas
CREATE TABLE asignaciones_tareas(
	id_part_proyecto INT NOT NULL,
	id_tarea INT NOT NULL,
	fecha_asignacion DATE NOT NULL
	CONSTRAINT FK_part_proyecto_asignacionesTareas FOREIGN KEY (id_part_proyecto)
		REFERENCES participantes_proyecto(id),
	CONSTRAINT FK_tarea_asignacionesTareas FOREIGN KEY (id_tarea) REFERENCES tareas(id)
);

-- 7. Comentarios
CREATE TABLE comentarios(
	id INT PRIMARY KEY IDENTITY(1,1),
	id_part_proyecto INT NULL,
	fecha_comentario DATETIME NOT NULL,
	contenido TEXT NOT NULL,
	CONSTRAINT FK_part_proyecto_comentarios FOREIGN KEY (id_part_proyecto)
		REFERENCES participantes_proyecto(id)
);