@echo off
setlocal enabledelayedexpansion

REM Obtener la ruta del directorio actual
set "currentDir=%~dp0"

REM Subir dos niveles desde la ubicación actual del script
set "baseDir=%currentDir%..\.."

REM Ruta al archivo routes.txt
set "routesFilePath=%currentDir%routes.txt"

REM Crear las rutas especificadas
set "route1Path=%baseDir%\source\201612211000"
set "route2Path=%baseDir%\source\org.eclipse.e4.tools"
set "route3Path=%baseDir%\source\orbit-buildrepo-R20160221192158"

REM Crear las carpetas si no existen
if not exist "%route1Path%" mkdir "%route1Path%"
if not exist "%route2Path%" mkdir "%route2Path%"
if not exist "%route3Path%" mkdir "%route3Path%"

REM Convertir las rutas a URIs válidas
for %%i in ("%route1Path%") do set "route1=file:/%%~fi"
for %%i in ("%route2Path%") do set "route2=file:/%%~fi"
for %%i in ("%route3Path%") do set "route3=file:/%%~fi"

REM Reemplazar las barras invertidas por barras diagonales
set "route1=%route1:\=/%"
set "route2=%route2:\=/%"
set "route3=%route3:\=/%"

REM Borrar el contenido del archivo routes.txt y escribir las nuevas rutas
(
    echo %route1%
    echo %route2%
    echo %route3%
) > "%routesFilePath%"

REM Leer las primeras tres líneas del archivo routes.txt nuevamente
set "route1="
set "route2="
set "route3="
for /f "tokens=1* delims=:" %%a in ('findstr /n "^" "%routesFilePath%"') do (
    if "%%a"=="1" set "route1=%%b"
    if "%%a"=="2" set "route2=%%b"
    if "%%a"=="3" set "route3=%%b"
    if defined route3 goto :break
)
:break

REM Ruta al archivo de definición de target
set "targetFilePath=%currentDir%org.eclipse.papyrus.information.modeling.targetplatform.neon.target"

REM Leer el contenido del archivo de definición de target y reemplazar las rutas en las líneas específicas
set "tempFile=%targetFilePath%.tmp"
set "lineNumber=0"
(for /f "delims=" %%i in (%targetFilePath%) do (
    set /a lineNumber+=1
    set "line=%%i"
    if !lineNumber! equ 51 set "line=<repository id="eclipse-neon" location="%route1%"/>"
    if !lineNumber! equ 55 set "line=<repository id="e4-tools" location="%route2%"/>"
    if !lineNumber! equ 69 set "line=<repository id="orbit" location="%route3%"/>"
    echo !line!
)) > %tempFile%

REM Reemplazar el archivo original con el archivo temporal
move /y %tempFile% %targetFilePath%

echo Archivo de definición de target actualizado con las nuevas rutas.