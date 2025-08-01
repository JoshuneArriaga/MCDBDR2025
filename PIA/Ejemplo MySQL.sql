
-- Activar el log de todas las actividades
SET GLOBAL general_log = 'ON';
SET GLOBAL general_log_file = 'C:/mysql_logs/general.log';

-- Activar el log de consultas lentas
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 2;  -- 2 segundos o más
SET GLOBAL slow_query_log_file = 'C:/mysql_logs/slow_queries.log';


-- Generar comandos mysqldump para todas las tablas
SELECT CONCAT(
    'mysql -u root -p --single-transaction DATAMART ',
    table_name,
    ' > "backup_',
    table_name,
    '_', DATE_FORMAT(NOW(), '%Y%m%d'), '.sql"'
) AS comando_backup
FROM information_schema.tables
WHERE table_schema = 'DATAMART'
AND table_name IN ('paises', 'migracion', 'economia', 'poblacion');


