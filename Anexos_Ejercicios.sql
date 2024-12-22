USE consultoria_proyectos_db;
GO

-- 1. Listar colaboradores asignados a un proyecto

-- Enunciado: Generar una consulta que muestre el nombre completo de los colaboradores
-- asignados a un proyecto específico, junto con su rol dentro del proyecto.

SELECT 
    c.nombre_completo AS 'Colaborador',
    pp.rol_proyecto AS 'Rol'
FROM colaboradores c
INNER JOIN participantes_proyecto pp ON c.id = pp.id_colaborador
WHERE pp.id_proyecto = 4;

-- 2. Creación de una vista de proyectos activos

-- Enunciado: Crear una vista que liste los proyectos con estado “En progreso”,
-- incluyendo el nombre del cliente asociado.

-- Solución:

CREATE VIEW Vista_Proyectos_Activos AS
SELECT 
    p.nombre_proyecto AS 'Proyecto', 
    p.fecha_inicio AS 'Fecha de inicio', 
    p.fecha_fin AS 'Fecha de fin', 
    c.razon_social AS 'Cliente'
FROM proyectos p
INNER JOIN clientes c ON p.id_cliente = c.id
WHERE p.estado = 'En progreso';

SELECT * FROM Vista_Proyectos_Activos;

-- 3. Obtener tareas por estado y proyecto

-- Enunciado: 
-- Crear una consulta que liste todas las tareas de un proyecto específico,
-- indicando el nombre de la tarea, el nombre completo del colaborador,
-- el estado de la tarea, y el nombre del proyecto asociado. 

-- Solución:

SELECT 
    t.nombre_tarea AS 'Tarea', 
	co.nombre_completo AS 'Colaborador',
    t.estado AS 'Estado de la tarea', 
    p.nombre_proyecto AS 'Proyecto'
FROM proyectos p
INNER JOIN participantes_proyecto pp ON pp.id_proyecto = p.id
INNER JOIN asignaciones_tareas asig_t ON asig_t.id_part_proyecto = pp.id
INNER JOIN tareas t ON t.id = asig_t.id_tarea
INNER JOIN colaboradores co ON pp.id_colaborador = co.id
WHERE p.id = 7;

-- 4. Consultar tareas asignadas a un colaborador

-- Enunciado: Realizar una consulta que muestre las tareas asignadas a un colaborador específico,
-- incluyendo el nombre del proyecto, la fecha de asignación y el estado de la tarea.

-- Solución:

SELECT
    t.nombre_tarea AS 'Tarea', 
		p.nombre_proyecto AS 'Proyecto',
    asig_t.fecha_asignacion AS 'Fecha de Asignación', 
    t.estado AS 'Estado'
FROM tareas t
INNER JOIN asignaciones_tareas asig_t ON t.id = asig_t.id_tarea
INNER JOIN participantes_proyecto pp ON pp.id = asig_t.id_part_proyecto
INNER JOIN proyectos p ON p.id = pp.id_proyecto
WHERE 
    asig_t.id_part_proyecto IN (
        SELECT id 
        FROM participantes_proyecto
        WHERE id_colaborador = 1
    );

-- 5. Función para calcular duración de proyectos

-- Enunciado: Crear una función escalar que reciba el ID de un proyecto
-- y retorne la duración en días (diferencia entre fecha_inicio y fecha_fin).

-- Solución:

CREATE FUNCTION Calcular_Duracion_Proyecto(@proyecto_id INT)
RETURNS INT
AS
BEGIN
    DECLARE @duracion INT;
    SELECT @duracion = DATEDIFF(DAY, fecha_inicio, fecha_fin)
    FROM proyectos p
    WHERE p.id = @proyecto_id;
    RETURN @duracion;
END;

SELECT
	*,
	dbo.Calcular_Duracion_Proyecto(p.id) AS 'Duración'
FROM proyectos p;

-- 6. Procedimiento para agregar un comentario a un proyecto

-- Enunciado: Crear un procedimiento almacenado que reciba el ID de un participante, 
-- el contenido del comentario y lo inserte en la tabla Comentarios.

-- Solución:

CREATE PROCEDURE Agregar_Comentario
    @id_part_proyecto INT,
    @contenido NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO comentarios (id_part_proyecto, fecha_comentario, contenido)
    VALUES (@id_part_proyecto, GETDATE(), @contenido);
END;

EXEC Agregar_Comentario @id_part_proyecto = 12, @contenido = 'El proyecto se piensa retomar el otro año';
SELECT * FROM comentarios;

-- 7. Proyectos con más de 3 participantes

-- Enunciado: Diseñar una consulta que liste los proyectos con más de tres participantes asignados.

-- Solución:

SELECT 
    p.nombre_proyecto AS 'Proyecto',
    COUNT(PP.id_colaborador) AS 'Cantidad de participantes'
FROM proyectos p
INNER JOIN participantes_proyecto pp ON p.id = pp.id_proyecto
GROUP BY p.nombre_proyecto
HAVING COUNT(pp.id_colaborador) > 3;

-- 8. Elaborar una CTE (Expresión de tabla común)
-- Enunciado: Encontrar los colaboradores que participan en 2 o más proyectos.
-- Mostrar el nombre y la cantidad de proyectos en los que participa.

-- Solución:

WITH CTE_Colaboradores AS (
    SELECT 
        pp.id_colaborador,
        co.nombre_completo,
        COUNT(pp.id_proyecto) AS total_proyectos
    FROM participantes_proyecto pp
    INNER JOIN colaboradores co ON pp.id_colaborador = co.id
    GROUP BY pp.id_colaborador, co.nombre_completo
)
SELECT
    nombre_completo AS 'Colaborador',
    total_proyectos AS 'Total de Proyectos'
FROM CTE_Colaboradores
WHERE total_proyectos >= 2;

-- 9. Detalle de comentarios recientes en proyectos activos

-- Enunciado: Crear una consulta que muestre los comentarios realizados
-- en proyectos con estado “En progreso” durante los últimos 30 días.

SELECT 
    p.nombre_proyecto AS 'Proyecto',
    ct.contenido AS 'Comentario', 
    ct.fecha_comentario AS 'Fecha'
FROM comentarios ct
INNER JOIN participantes_proyecto pp ON ct.id_part_proyecto = pp.id
INNER JOIN proyectos p ON pp.id_proyecto = p.id
WHERE 
    p.estado = 'En progreso' AND 
    ct.fecha_comentario >= DATEADD(DAY, -30, GETDATE());

-- 10. Inserción automática de comentarios
-- Enunciado: Crear un trigger que inserte un comentario automático en la tabla de Comentarios
-- cada vez que se cree un nuevo proyecto, indicando que el proyecto fue creado.

CREATE TRIGGER InsertarComentarioProyecto
ON proyectos
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO comentarios (id_part_proyecto, fecha_comentario, contenido)
    SELECT 
        NULL,
        GETDATE(), 
        'El proyecto "' + I.nombre_proyecto + '" ha sido creado.'
    FROM 
        inserted I;
END;

INSERT INTO proyectos (nombre_proyecto, descripcion, fecha_inicio, fecha_fin, estado, id_cliente)
VALUES ('Proyecto A', 'Esto es una prueba del ejercicio 10', '2025-01-02', '2025-02-28', 'En progreso', 1);

SELECT * FROM proyectos;
SELECT * FROM comentarios;

-- 11. Función de la tabla
-- Enunciado: Crear una función de tabla que reciba un ID de colaborador
-- y devuelva todas las tareas asignadas a ese colaborador.

CREATE FUNCTION FN_NH_TAREAS_ASIGNADAS(@id_Colaborador INT)
RETURNS TABLE
AS
RETURN
(
    SELECT
		co.nombre_completo AS 'Colaborador',
        t.id AS 'ID Tarea',
        t.nombre_tarea AS 'Tarea',
        t.estado AS 'Estado',
        t.fecha_limite AS 'Fecha Límite'
    FROM asignaciones_tareas asig_tareas
    INNER JOIN tareas t ON asig_tareas.id_tarea= t.id
	INNER JOIN colaboradores co ON co.id = @id_Colaborador
	INNER JOIN participantes_proyecto pp ON pp.id = asig_tareas.id_part_proyecto
    WHERE pp.id_colaborador = @id_Colaborador
);

SELECT * FROM FN_NH_TAREAS_ASIGNADAS(3);