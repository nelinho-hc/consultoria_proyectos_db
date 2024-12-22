USE consultoria_proyectos_db;
GO

-- IMPORTAR DATOS DESDE UN TXT A UNA TABLA YA CREADA

BULK INSERT dbo.colaboradores
FROM 'E:\Desktop\ZERO\Cursos\Bootcamp Análisis de Datos\Bootcamp SQL Server\Proyecto Final\Colaboradores.txt'
WITH
(
	FIELDTERMINATOR = '|',	-- Define el campo separador
	ROWTERMINATOR = '\n',	-- Define el terminador de fila (línea nueva)
	FIRSTROW = 2,			-- Define desde que fila empezar (omite las cabeceras)
	CODEPAGE = '65001',		-- Acepta carácteres especiales
	TABLOCK					-- Bloquea la tabla mientas se insertan los datos
);

BULK INSERT dbo.clientes
FROM 'E:\Desktop\ZERO\Cursos\Bootcamp Análisis de Datos\Bootcamp SQL Server\Proyecto Final\Clientes.txt'
WITH
(
	FIELDTERMINATOR = '|',	-- Define el campo separador
	ROWTERMINATOR = '\n',	-- Define el terminador de fila (línea nueva)
	FIRSTROW = 2,			-- Define desde que fila empezar (omite las cabeceras)
	CODEPAGE = '65001',		-- Acepta carácteres especiales
	TABLOCK					-- Bloquea la tabla mientas se insertan los datos
);

SELECT * FROM colaboradores;
SELECT * FROM clientes;

-- INSERTAR DATOS CON CÓDIGO SQL

INSERT INTO proyectos (nombre_proyecto, descripcion, fecha_inicio, fecha_fin, estado, id_cliente)
VALUES
('Transformación Digital en IBK', 'Se realizará un cambio a nivel tecnológico en Interbank',
'2024-05-06', '2024-10-31', 'Completado', '8'),
('Auditoría contable en la PUCP', 'Servicios de auditoría en la universidad',
'2024-11-04', '2024-12-23', 'En progreso', '7'),
('Monitorear compras de ASUS', 'Asesorías en las oficinas de ASUS',
'2024-11-20', '2024-11-22', 'Cancelado', '12'),
('Nuevo Sistema de Ciberseguridad en BBVA', 'Implementar una nueva alternativa de Ciberseguridad en BBVA',
'2024-09-23', '2025-01-09', 'En progreso', '6'),
('Asesorías contables en VIVIENDA', 'Liderar las asesorías contables en el Ministerior de Vivienda',
'2024-05-20', '2024-07-31', 'Completado', '10'),
('Automatización de procesos en LOreal', 'Proponer mejoras en la automatización de procesos para LOreal Perú',
'2024-06-10', '2024-06-28', 'Cancelado', '3'),
('Administrar bases de datos de GM', 'Realizar la administración y mantenimiento de BD para General Motors',
'2024-12-02', '2025-02-14', 'En progreso', '4');

INSERT INTO participantes_proyecto (id_colaborador, id_proyecto, fecha_incorporacion, rol_proyecto)
VALUES
('1', '2', '2024-11-11', 'Miembro'),
('7', '2', '2024-11-11', 'Miembro'),
('5', '2', '2024-11-05', 'Miembro'),
('8', '2', '2024-11-04', 'Supervisor'),
('17', '2', '2024-11-05', 'Supervisor'),
('1', '1', '2024-05-20', 'Miembro'),
('2', '1', '2024-06-17', 'Miembro'),
('3', '1', '2024-05-06', 'Miembro'),
('4', '1', '2024-05-06', 'Supervisor'),
('3', '6', '2024-06-10', 'Miembro'),
('4', '6', '2024-06-10', 'Miembro'),
('9', '6', '2024-06-10', 'Supervisor'),
('11', '3', '2024-11-20', 'Miembro'),
('20', '3', '2024-11-20', 'Supervisor'),
('12', '5', '2024-05-21', 'Miembro'),
('13', '5', '2024-06-03', 'Miembro'),
('15', '5', '2024-05-20', 'Miembro'),
('16', '5', '2024-05-20', 'Supervisor'),
('6', '4', '2024-10-01', 'Miembro'),
('10', '4', '2024-09-24', 'Miembro'),
('11', '4', '2024-09-25', 'Miembro'),
('14', '4', '2024-09-23', 'Miembro'),
('8', '4', '2024-09-23', 'Supervisor'),
('18', '7', '2024-12-06', 'Miembro'),
('19', '7', '2024-12-09', 'Miembro'),
('3', '7', '2024-12-02', 'Miembro'),
('4', '7', '2024-12-02', 'Supervisor');

INSERT INTO tareas (nombre_tarea, fecha_inicio, fecha_limite, estado)
VALUES
('Investigar nuevas tecnologías', '2024-05-20', '2024-05-31', 'Completado'),
('Realizar pruebas de simulación', '2024-06-17', '2024-06-24', 'Completado'),
('Presentar prototipo al cliente', '2024-09-30', '2024-09-30', 'Completado'),
('Solicitar información a la PUCP', '2024-11-04', '2024-11-11', 'Completado'),
('Reunión con el cliente', '2024-12-20', '2024-12-20', 'Pendiente'),
('Revisar la información de compras de ASUS', '2024-11-20', '2024-11-22', 'Cancelado'),
('Conversar con el cliente para elaborar propuestas', '2024-09-23', '2024-10-11', 'Completado'),
('Realizar pruebas y simulaciones', '2024-11-28', '2024-12-20', 'En progreso'),
('Mostrar solución final al cliente', '2025-01-03', '2025-01-03', 'Pendiente'),
('Reunir información contable de VIVIENDA', '2024-05-20', '2024-05-31', 'Completado'),
('Consolidar los libros diarios', '2024-06-10', '2024-06-25', 'Completado'),
('Enviar documento final al cliente', '2024-07-24', '2024-07-31', 'Completado'),
('Elaborar prototipos funcionales LOreal', '2024-06-10', '2024-06-28', 'Cancelado'),
('Reunir con el cliente para solicitar más información', '2024-12-02', '2024-12-04', 'Completado'),
('Administrar la primera etapa de mantenimiento de BD', '2025-01-06', '2025-01-14', 'Pendiente'),
('Elaborar un código en Python que automatice BD', '2024-12-06', '2024-12-13', 'Cancelado'),
('Realizar limpieza de datos de la BD del cliente', '2024-12-10', '2024-12-23', 'En progreso');

INSERT INTO asignaciones_tareas (id_part_proyecto, id_tarea, fecha_asignacion)
VALUES

-- Proyecto 1
('6', '1', '2024-05-20'),
('6', '2', '2024-06-17'),
('7', '2', '2024-09-30'),
('6', '3', '2024-09-30'),
('7', '3', '2024-06-17'),
('8', '3', '2024-09-30'),
('9', '3', '2024-09-30'),

-- Proyecto 2
('1', '4', '2024-11-05'),
('2', '4', '2024-11-04'),
('3', '4', '2024-11-06'),
('4', '5', '2024-12-13'),
('5', '5', '2024-12-13'),

-- Proyecto 3
('13', '6', '2024-11-20'),
('14', '6', '2024-11-20'),

-- Proyecto 4
('19', '7', '2024-09-23'),
('20', '7', '2024-09-25'),
('21', '7', '2024-09-28'),
('21', '8', '2024-11-28'),
('22', '8', '2024-11-28'),
('22', '9', '2024-12-13'),
('23', '9', '2024-12-13'),

-- Proyecto 5
('15', '10', '2024-05-20'),
('16', '10', '2024-05-20'),
('15', '11', '2024-06-10'),
('16', '11', '2024-06-10'),
('17', '11', '2024-06-10'),
('17', '12', '2024-07-24'),
('18', '12', '2024-07-24'),

-- Proyecto 6
('10', '13', '2024-06-10'),
('11', '13', '2024-06-10'),
('12', '13', '2024-06-10'),

--Proyecto 7
('24', '14', '2024-12-03'),
('25', '14', '2024-12-02'),
('26', '14', '2024-12-02'),
('26', '15', '2024-12-13'),
('27', '15', '2024-12-13'),
('26', '16', '2024-12-06'),
('24', '17', '2024-12-10'),
('25', '17', '2024-12-10');

INSERT INTO comentarios (id_part_proyecto, fecha_comentario, contenido)
VALUES
-- Proyecto 1
('6', '2024-07-15 10:20:00', 'El avance en la implementación tecnológica es satisfactorio.'),
('7', '2024-09-01 09:00:00', 'Interbank ha solicitado un informe detallado de los progresos.'),
('3', '2024-10-05 15:45:00', 'Se requiere ajustar el cronograma final para las pruebas de sistemas.'),

-- Proyecto 2
('3', '2024-11-10 10:15:00', 'Los estados financieros preliminares fueron enviados al cliente.'),
('2', '2024-11-20 11:30:00', 'Se programó una reunión con la PUCP para resolver dudas técnicas.'),
('4', '2024-12-15 14:10:00', 'Es necesario revisar las observaciones realizadas en la última auditoría.'),

-- Proyecto 3
('14', '2024-11-21 09:45:00', 'El cliente canceló los servicios con la empresa.'),
    
-- Proyecto 4
('20', '2024-10-10 10:00:00', 'El diseño del nuevo sistema de ciberseguridad ha sido aprobado.'),
('19', '2024-11-01 16:20:00', 'Se detectaron vulnerabilidades en la red que deben ser resueltas.'),
('22', '2024-12-05 14:50:00', 'Se completó la configuración inicial de los nuevos sistemas de seguridad.'),

-- Proyecto 5
('15', '2024-06-01 09:15:00', 'El Ministerio solicitó una revisión del informe de asesorías.'),
('17', '2024-07-15 11:40:00', 'Se completó la capacitación al equipo del Ministerio de Vivienda.'),
    
-- Proyecto 6
('12', '2024-06-12 10:10:00', 'El cliente ha solicitado la cancelación del servicio.'),
    
-- Proyecto 7
('25', '2024-12-03 08:50:00', 'Se configuraron las nuevas bases de datos para General Motors.'),
('24', '2024-12-10 14:30:00', 'Es necesario ajustar el tamaño del almacenamiento de datos.'),
('27', '2024-12-12 10:45:00', 'Se identificaron inconsistencias en los datos históricos.'),
('26', '2024-12-13 15:55:00', 'Hubo problemas en codificar la propuesta de automatización.');

SELECT * FROM proyectos;
SELECT * FROM participantes_proyecto;
SELECT * FROM tareas;
SELECT * FROM asignaciones_tareas;
SELECT * FROM comentarios;