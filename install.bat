@echo off
setlocal

REM Guardar la ruta del directorio actual
set "initialDir=%cd%"

REM Obtener la ruta del directorio donde se encuentra el script
set "scriptDir=%~dp0"

REM Verificar si la carpeta targetplatform existe
if not exist "%scriptDir%targetplatform" (
    echo Error: La carpeta targetplatform no existe.
    pause
    exit /b 1
)

REM Entrar en la carpeta targetplatform
cd "%scriptDir%targetplatform"

REM Verificar si la carpeta org.eclipse.papyrus.information.modeling.targetplatform.neon existe
if not exist "org.eclipse.papyrus.information.modeling.targetplatform.neon" (
    echo Error: La carpeta org.eclipse.papyrus.information.modeling.targetplatform.neon no existe.
    pause
    exit /b 1
)

REM Entrar en la carpeta org.eclipse.papyrus.information.modeling.targetplatform.neon
cd org.eclipse.papyrus.information.modeling.targetplatform.neon

REM Verificar si update.bat existe
if not exist "update.bat" (
    echo Error: El archivo update.bat no existe.
    pause
    exit /b 1
)

REM Ejecutar update.bat
call update.bat

REM Verificar si update.bat se ejecutó correctamente
if %errorlevel% neq 0 (
    echo Error: Fallo en la ejecución de update.bat.
    pause
    exit /b %errorlevel%
)

REM Regresar al directorio inicial
cd "%initialDir%"

REM Verificar si build.bat existe
if not exist "build.bat" (
    echo Error: El archivo build.bat no existe.
    pause
    exit /b 1
)

REM Ejecutar build.bat
call build.bat

REM Verificar si build.bat se ejecutó correctamente
if %errorlevel% neq 0 (
    echo Error: Fallo en la ejecución de build.bat.
    pause
    exit /b %errorlevel%
)

REM Verificar si extract.bat existe
if not exist "extract.bat" (
    echo Error: El archivo extract.bat no existe.
    pause
    exit /b 1
)

REM Ejecutar extract.bat
call extract.bat

REM Verificar si extract.bat se ejecutó correctamente
if %errorlevel% neq 0 (
    echo Error: Fallo en la ejecución de extract.bat.
    pause
    exit /b %errorlevel%
)