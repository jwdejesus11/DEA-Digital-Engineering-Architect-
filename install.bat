@echo off
setlocal

REM Guardar la ruta del directorio actual
set "initialDir=%cd%"

REM Entrar en la carpeta targetplatform/org.eclipse.papyrus.information.modeling.targetplatform.neon
cd targetplatform\org.eclipse.papyrus.information.modeling.targetplatform.neon

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

REM Ejecutar build.bat
call build.bat

REM Verificar si build.bat se ejecutó correctamente
if %errorlevel% neq 0 (
    echo Error: Fallo en la ejecución de build.bat.
    pause
    exit /b %errorlevel%
)

REM Ejecutar extract.bat
call extract.bat

REM Verificar si extract.bat se ejecutó correctamente
if %errorlevel% neq 0 (
    echo Error: Fallo en la ejecución de extract.bat.
    exit /b %errorlevel%
)