library(RPostgreSQL)
library(DBI)


fun_getConn <- function(usuario='postgres', contrasena = 'Restart456', db = "Maestria_BD") {
  
    return(
            dbConnect(dbDriver("PostgreSQL"),
            dbname = ,
            host = "localhost",  
            port = 5432,
            user = usuario,
            password = contrasena))
  }


query_connections <- "
  SELECT usename as usuario,
         application_name,
         client_addr as ip_cliente,
         backend_start as inicio_conexion,
         state as estado,
         current_timestamp AS timestamp_auditoria
  FROM pg_stat_activity 
  WHERE pid <> pg_backend_pid()"

conn <- fun_getConn()

query_sizes <- "
  SELECT pg_namespace.nspname as schema_name,
         pg_class.relname as table_name,
         pg_size_pretty(pg_relation_size(pg_class.oid)) as size,
         current_timestamp AS timestamp_auditoria
  FROM pg_catalog.pg_class
  JOIN pg_catalog.pg_namespace ON relnamespace = pg_namespace.oid
  ORDER BY pg_relation_size(pg_class.oid) DESC"

timestamp <- format(Sys.time(), "%Y%m%d_%H%M%S")
directorio <- "C:/Users/joshu/Documents/Maestría/audit_logs/"

df_connections <- dbGetQuery(conn, query_connections)
df_sizes <- dbGetQuery(conn, query_sizes)

write.csv(df_connections, 
          paste0(directorio, "audit_connections_", timestamp, ".csv"))

write.csv(df_sizes, 
          paste0(directorio, "audit_sizes_", timestamp, ".csv"))

db_config <- list(
  host = "localhost",
  user = "postgres",
  database = "Maestria_BD",
  password = "Restart456"
)

fun_backup_database <- function(db_config, backup_path) {

  Sys.setenv(PGPASSWORD = db_config$password)
  
  timestamp <- format(Sys.time(), "%Y%m%d_%H%M%S")
  backup_file <- paste0(backup_path, db_config$database, "_", timestamp, ".backup")
  

  result <- system2(
    "C:/Program Files/PostgreSQL/15/bin/pg_dump.exe",
    args = c("-h", db_config$host, "-U", db_config$user, "-d", db_config$database, 
             "-Fc", "-f", backup_file),
    stdout = TRUE, stderr = TRUE
  )
  
  message("Backup creado: ", backup_file)
}

fun_backup_database(db_config, "C:/Users/joshu/Documents/Maestría/audit_backups/")

fun_restore_database <- function(db_config, backup_file) {
  Sys.setenv(PGPASSWORD = db_config$password)
  
  result <- system2(
    "C:/Program Files/PostgreSQL/15/bin/pg_restore.exe",
    args = c("-h", db_config$host, "-U", db_config$user, "-d", db_config$database, 
             "-v", "--clean", "--if-exists", backup_file),
    stdout = TRUE, stderr = TRUE
  )
  
  message("Restore completado desde: ", backup_file)
  if (length(result) > 0) {
    cat("Salida:\n", result, sep = "\n")
  }
}

backup_file <- "C:/Users/joshu/Documents/Maestría/audit_backups/Maestria_BD_20250731_160755.backup"
fun_restore_database(db_config, backup_file)
dbDisconnect(conn)
