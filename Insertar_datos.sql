USE consultoria_proyectos_db;
GO

-- IMPORTAR DATOS DESDE UN TXT A UNA TABLA YA CREADA

BULK INSERT dbo.colaboradores
FROM 'E:\Desktop\ZERO\Cursos\Bootcamp An�lisis de Datos\Bootcamp SQL Server\Proyecto Final\Colaboradores.txt'
WITH
(
	FIELDTERMINATOR = '|',	-- Define el campo separador
	ROWTERMINATOR = '\n',	-- Define el terminador de fila (l�nea nueva)
	FIRSTROW = 2,			-- Define desde que fila empezar (omite las cabeceras)
	CODEPAGE = '65001',		-- Acepta car�cteres especiales
	TABLOCK					-- Bloquea la tabla mientas se insertan los datos
);

BULK INSERT dbo.clientes
FROM 'E:\Desktop\ZERO\Cursos\Bootcamp An�lisis de Datos\Bootcamp SQL Server\Proyecto Final\Clientes.txt'
WITH
(
	FIELDTERMINATOR = '|',	-- Define el campo separador
	ROWTERMINATOR = '\n',	-- Define el terminador de fila (l�nea nueva)
	FIRSTROW = 2,			-- Define desde que fila empezar (omite las cabeceras)
	CODEPAGE = '65001',		-- Acepta car�cteres especiales
	TABLOCK					-- Bloquea la tabla mientas se insertan los datos
);

SELECT * FROM colaboradores;
SELECT * FROM clientes;

-- INSERTAR DATOS CON C�DIGO SQL

INSERT INTO proyectos (nombre_proyecto, descripcion, fecha_inicio, fecha_fin, estado, id_supervisor, id_cliente)
VALUES
('Transformaci�n Digital en IBK', 'Se realizar� un cambio a nivel tecnol�gico en Interbank',
'2024-05-06', '2024-10-31', 'Completado', '4', '8'),
('Auditor�a contable en la PUCP', 'Servicios de auditor�a en la universidad',
'2024-11-04', '2024-12-23', 'En progreso', '17', '7'),
('Monitorear compras de ASUS', 'Asesor�as en las oficinas de ASUS',
'2024-11-20', '2024-11-22', 'Cancelado', '20', '12'),
('Nuevo Sistema de Ciberseguridad en BBVA', 'Implementar una nueva alternativa de Ciberseguridad en BBVA',
'2024-09-23', '2025-01-09', 'En progreso', '8', '6'),
('Asesor�as contables en VIVIENDA', 'Liderar las asesor�as contables en el Ministerior de Vivienda',
'2024-05-20', '2024-07-31', 'Completado', '16', '10'),
('Automatizaci�n de procesos en LOreal', 'Proponer mejoras en la automatizaci�n de procesos para LOreal Per�',
'2024-06-10', '2024-06-28', 'Cancelado', '9', '3'),
('Administrar bases de datos de GM', 'Realizar la administraci�n y mantenimiento de BD para General Motors',
'2024-12-02', '2025-02-14', 'En progreso', '4', '4');

INSERT INTO participantes_proyectos (id_colaborador, id_proyecto, fecha_asignacion, rol_proyecto)
VALUES
('1', '2', '2024-11-11', 'Miembro'),
('7', '2', '2024-11-11', 'Miembro'),
('5', '2', '2024-11-05', 'Miembro'),
('8', '2', '2024-11-04', 'Jefe'),
('1', '1', '2024-05-20', 'Miembro'),
('2', '1', '2024-06-17', 'Miembro'),
('3', '1', '2024-05-06', 'Jefe'),
('3', '6', '2024-06-10', 'Miembro'),
('4', '6', '2024-06-10', 'Jefe'),
('11', '3', '2024-11-20', 'Miembro'),
('20', '3', '2024-11-20', 'Jefe'),
('12', '5', '2024-05-21', 'Miembro'),
('13', '5', '2024-06-03', 'Miembro'),
('15', '5', '2024-05-20', 'Jefe'),
('6', '4', '2024-10-01', 'Miembro'),
('10', '4', '2024-09-23', 'Miembro'),
('11', '4', '2024-09-25', 'Miembro'),
('14', '4', '2024-09-23', 'Jefe'),
('18', '7', '2024-12-06', 'Miembro'),
('19', '7', '2024-12-09', 'Miembro'),
('3', '7', '2024-12-02', 'Jefe');

INSERT INTO tareas (id_proyecto, nombre_tarea, fecha_inicio, fecha_limite, estado)
VALUES
('1', 'Investigar nuevas tecnolog�as', '2024-05-20', '2024-05-31', 'Completado'),
('1', 'Realizar pruebas de simulaci�n', '2024-06-17', '2024-06-24', 'Completado'),
('1', 'Presentar prototipo al cliente', '2024-09-30', '2024-09-30', 'Completado'),
('2', 'Solicitar informaci�n a la PUCP', '2024-11-04', '2024-11-11', 'Completado'),
('2', 'Reuni�n con el cliente', '2024-12-20', '2024-12-20', 'Pendiente'),
('3', 'Revisar la informaci�n de compras de ASUS', '2024-11-20', '2024-11-22', 'Cancelado'),
('4', 'Conversar con el cliente para elaborar propuestas', '2024-09-23', '2024-10-11', 'Completado'),
('4', 'Realizar pruebas y simulaciones', '2024-11-28', '2024-12-20', 'En progreso'),
('4', 'Mostrar soluci�n final al cliente', '2025-01-03', '2025-01-03', 'Pendiente'),
('5', 'Reunir informaci�n contable de VIVIENDA', '2024-05-20', '2024-05-31', 'Completado'),
('5', 'Consolidar los libros diarios', '2024-06-10', '2024-06-25', 'Completado'),
('5', 'Enviar documento final al cliente', '2024-07-24', '2024-07-31', 'Completado'),
('6', 'Elaborar prototipos funcionales LOreal', '2024-06-10', '2024-06-28', 'Cancelado'),
('7', 'Reunir con el cliente para solicitar m�s informaci�n', '2024-12-02', '2024-12-04', 'Completado'),
('7', 'Administrar la primera etapa de mantenimiento de BD', '2025-01-06', '2025-01-14', 'Pendiente'),
('7', 'Elaborar un c�digo en Python que automatice BD', '2024-12-06', '2024-12-13', 'Cancelado'),
('7', 'Realizar limpieza de datos de la BD del cliente', '2024-12-10', '2024-12-23', 'En progreso');

INSERT INTO hitos (nombre_hito, fecha_limite, estado, descripcion, id_tarea)
VALUES
('Finalizaci�n las simulaciones', '2024-06-24', 'Completado', 'OK', '2'),
('Obtenci�n de informaci�n de la PUCP', '2024-11-11', 'Completado', 'OK', '4'),
('Conclusi�n de la reuni�n con el cliente', '2024-12-20', 'Pendiente', '', '5'),
('Finalizaci�n la revisi�n de ASUS', '2024-11-22', 'Cancelado', 'El cliente se retir�', '6'),
('Cerrado de propuestas con el cliente', '2024-10-11', 'Completado', 'OK', '7'),
('�ltimos pasos en las pruebas', '2024-12-20', 'Pendiente', '', '8'),
('Visto bueno del cliente', '2025-01-03', 'Pendiente', '', '9'),
('Finalizaci�n de la etapa de recibimiento de informaci�n', '2024-05-31', 'Completado', 'OK', '10'),
('Conclusi�n de la consolidaci�n', '2024-06-25', 'Completado', '', '11'),
('Confirmaci�n del cliente', '2024-07-31', 'Completado', 'El cliente result� satisfecho', '12'),
('Finalizaci�n de la elaboraci�n de prototipos', '2024-06-28', 'Cancelado',
	'El cliente no se reportaba', '13'),
('Indicaciones del cliente', '2024-12-04', 'Completado', 'El cliente brind� toda la informaci�n', '14'),
('Finalizaci�n de la primera etapa de mantenimiento', '2025-01-14', 'Pendiente', '', '15'),
('Presentaci�n de la propuesta de automatizaci�n al cliente', '2024-12-16',
	'Cancelado', 'Problemas en la codificaci�n', '16'),
('Finalizaci�n de la limpieza de datos de la BD', '2024-12-23', 'Pendiente', '', '17');

INSERT INTO asignaciones_tareas (id_colaborador, id_tarea, fecha_asignacion, rol_tarea)
VALUES

-- Proyecto 1
('1', '1', '2024-05-20', 'Participante'),
('1', '2', '2024-06-17', 'Participante'),
('2', '2', '2024-09-30', 'Participante'),
('1', '3', '2024-09-30', 'Participante'),
('2', '3', '2024-06-17', 'Participante'),
('3', '3', '2024-09-30', 'L�der'),

-- Proyecto 2
('1', '4', '2024-11-05', 'Participante'),
('5', '4', '2024-11-04', 'Participante'),
('7', '4', '2024-11-06', 'Participante'),
('5', '5', '2024-12-13', 'Participante'),
('8', '5', '2024-12-13', 'L�der'),

-- Proyecto 3
('11', '6', '2024-11-20', 'Participante'),
('20', '6', '2024-11-20', 'L�der'),

-- Proyecto 4
('6', '7', '2024-09-23', 'Participante'),
('10', '7', '2024-09-25', 'Participante'),
('11', '7', '2024-09-28', 'Participante'),
('10', '8', '2024-11-28', 'Participante'),
('11', '8', '2024-11-28', 'Participante'),
('6', '9', '2024-12-13', 'Participante'),
('14', '9', '2024-12-13', 'L�der'),

-- Proyecto 5
('12', '10', '2024-05-20', 'Participante'),
('13', '10', '2024-05-20', 'Participante'),
('12', '11', '2024-06-10', 'Participante'),
('13', '11', '2024-06-10', 'Participante'),
('15', '12', '2024-07-24', 'L�der'),

-- Proyecto 6
('3', '13', '2024-06-10', 'Participante'),
('4', '13', '2024-06-10', 'L�der'),

--Proyecto 7
('18', '14', '2024-12-03', 'Participante'),
('19', '14', '2024-12-02', 'Participante'),
('3', '14', '2024-12-02', 'L�der'),
('19', '15', '2024-12-13', 'Participante'),
('3', '15', '2024-12-13', 'L�der'),
('3', '16', '2024-12-06', 'Participante'),
('18', '14', '2024-12-10', 'Participante'),
('19', '14', '2024-12-10', 'Participante'),
('3', '17', '2024-12-10', 'L�der');

INSERT INTO comentarios (id_proyecto, id_colaborador, fecha_comentario, contenido)
VALUES
-- Proyecto 1
('1', '1', '2024-07-15 10:20:00', 'El avance en la implementaci�n tecnol�gica es satisfactorio.'),
('1', '2', '2024-09-01 09:00:00', 'Interbank ha solicitado un informe detallado de los progresos.'),
('1', '3', '2024-10-05 15:45:00', 'Se requiere ajustar el cronograma final para las pruebas de sistemas.'),

-- Proyecto 2
('2', '5', '2024-11-10 10:15:00', 'Los estados financieros preliminares fueron enviados al cliente.'),
('2', '7', '2024-11-20 11:30:00', 'Se program� una reuni�n con la PUCP para resolver dudas t�cnicas.'),
('2', '8', '2024-12-15 14:10:00', 'Es necesario revisar las observaciones realizadas en la �ltima auditor�a.'),

-- Proyecto 3
('3', '20', '2024-11-21 09:45:00', 'El cliente cancel� los servicios con la empresa.'),
    
-- Proyecto 4
('4', '10', '2024-10-10 10:00:00', 'El dise�o del nuevo sistema de ciberseguridad ha sido aprobado.'),
('4', '6', '2024-11-01 16:20:00', 'Se detectaron vulnerabilidades en la red que deben ser resueltas.'),
('4', '14', '2024-12-05 14:50:00', 'Se complet� la configuraci�n inicial de los nuevos sistemas de seguridad.'),

-- Proyecto 5
('5', '12', '2024-06-01 09:15:00', 'El Ministerio solicit� una revisi�n del informe de asesor�as.'),
('5', '15', '2024-07-15 11:40:00', 'Se complet� la capacitaci�n al equipo del Ministerio de Vivienda.'),
    
-- Proyecto 6
('6', '4', '2024-06-12 10:10:00', 'El cliente ha solicitado la cancelaci�n del servicio.'),
    
-- Proyecto 7
('7', '19', '2024-12-03 08:50:00', 'Se configuraron las nuevas bases de datos para General Motors.'),
('7', '18', '2024-12-10 14:30:00', 'Es necesario ajustar el tama�o del almacenamiento de datos.'),
('7', '3', '2024-12-12 10:45:00', 'Se identificaron inconsistencias en los datos hist�ricos.'),
('7', '3', '2024-12-13 15:55:00', 'Hubo problemas en codificar la propuesta de automatizaci�n.');

SELECT * FROM proyectos;
SELECT * FROM participantes_proyectos;
SELECT * FROM tareas;
SELECT * FROM hitos;
SELECT * FROM asignaciones_tareas;
SELECT * FROM comentarios;

SELECT * FROM tareas t1
INNER JOIN asignaciones_tareas t2 ON t1.id = t2.id_tarea
INNER JOIN colaboradores t3 ON t2.id_colaborador = t3.id