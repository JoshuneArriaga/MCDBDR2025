SET log_statement = 'all'
SET log_connections = on;
SET log_disconnections = on;
SET log_line_prefix = '%t [%p]: user=%u,db=%d';

--Ver conexiones activas
SELECT usename, application_name, client_addr, 
       backend_start, state, query
FROM pg_stat_activity 
WHERE state = 'active';

SHOW log_connections;
SHOW log_disconnections;


SELECT 
    'pg_dump -h localhost -U usuario -d Maestria_BD -t ' || table_name || 
    ' -Fc > "backup_' || table_name || '_' || 
    TO_CHAR(NOW(), 'YYYYMMDD') || '.backup"' AS comando_backup_custom,
    
    'pg_dump -h localhost -U usuario -d Maestria_BD -t ' || table_name || 
    ' > "backup_' || table_name || '_' || 
    TO_CHAR(NOW(), 'YYYYMMDD') || '.sql"' AS comando_backup_sql
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name IN ('economia', 'migracion', 'paises', 'poblacion');