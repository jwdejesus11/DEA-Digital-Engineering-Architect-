@echo off
setlocal enabledelayedexpansion

REM Obtener la ruta del directorio actual
set "currentDir=%~dp0"

REM Mostrar la ruta actual
echo La ruta actual es: %currentDir%

REM Guardar la ruta actual en una variable
set "originalDir=%currentDir%"

REM Subir dos niveles desde la ubicación actual del script
set "baseDir=%currentDir%..\.."
for %%i in ("%baseDir%") do set "baseDir=%%~fi"

REM Crear las rutas especificadas
set "route1Path=%baseDir%\source\201612211000"
set "route2Path=%baseDir%\source\org.eclipse.e4.tools"
set "route3Path=%baseDir%\source\orbit-buildrepo-R20160221192158"

REM Convertir las rutas a URIs válidas
for %%i in ("%route1Path%") do set "route1Path=location="file:/%%~fi""
for %%i in ("%route2Path%") do set "route2Path=location="file:/%%~fi""
for %%i in ("%route3Path%") do set "route3Path=location="file:/%%~fi""

REM Reemplazar las barras invertidas por barras diagonales
set "route1Path=%route1Path:\=/%"
set "route2Path=%route2Path:\=/%"
set "route3Path=%route3Path:\=/%"

REM Mostrar las nuevas rutas
echo Ruta 1: %route1Path%
echo Ruta 2: %route2Path%
echo Ruta 3: %route3Path%

REM Regresar a la ruta original
cd /d %currentDir%

REM Mostrar la ruta actual después de regresar
echo De vuelta a la ruta original: %currentDir%

REM Ruta al archivo routes.txt
set "routesFilePath=%currentDir%routes.txt"

echo %routesFilePath%

REM Borrar el contenido del archivo routes.txt y escribir las nuevas rutas
echo %route1Path% > "%routesFilePath%"
echo %route2Path% >> "%routesFilePath%"
echo %route3Path% >> "%routesFilePath%"

REM Mostrar el contenido del archivo routes.txt
type "%routesFilePath%"

REM Leer las líneas del archivo routes.txt
set "line1="
set "line2="
set "line3="
set "lineNumber=0"
for /f "delims=" %%i in ('type "!routesFilePath!"') do (
    set /a lineNumber+=1
    if !lineNumber! equ 1 set "line1=%%i"
    if !lineNumber! equ 2 set "line2=%%i"
    if !lineNumber! equ 3 set "line3=%%i"
)

REM Ruta al archivo de definición de target
set "targetFilePath=%currentDir%org.eclipse.papyrus.information.modeling.targetplatform.neon.target"

REM Leer el contenido del archivo de definición de target y reemplazar las rutas en las líneas específicas
set "tempFile=%targetFilePath%.tmp"
set "lineNumber=0"
(for /f "delims=" %%i in ('type "%targetFilePath%"') do (
    set /a lineNumber+=1
    set "line=%%i"
    if !lineNumber! equ 52 set line=%line1%
    if !lineNumber! equ 58 set line=%line2%
    if !lineNumber! equ 74 set line=%line3%
    echo !line!
)) > "%tempFile%"

REM Reemplazar el archivo original con el archivo temporal
move /y "%tempFile%" "%targetFilePath%"
