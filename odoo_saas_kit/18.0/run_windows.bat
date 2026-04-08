@echo off
setlocal

rem Keep defaults for compose variables used on Linux
if "%HOST_UID%"=="" set HOST_UID=1000
if "%HOST_GID%"=="" set HOST_GID=1000

rem Create directories explicitly matching docker-compose.yml
if not exist "container_data\postgres" mkdir "container_data\postgres"
if not exist "container_data\odoo" mkdir "container_data\odoo"
if not exist "container_data\config" mkdir "container_data\config"

rem Bring up containers
docker compose down --remove-orphans
if errorlevel 1 exit /b %errorlevel%

docker compose up --force-recreate
if errorlevel 1 exit /b %errorlevel%

endlocal
