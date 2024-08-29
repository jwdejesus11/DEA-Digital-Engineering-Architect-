@echo off

REM Cambiar a la ruta especificada
cd releng\org.eclipse.papyrus.information.modeling.product\target\products
if %errorlevel% neq 0 (
    echo Error: No se pudo cambiar a la ruta especificada.
    pause
    exit /b %errorlevel%
)

REM Verificar si el directorio actual es correcto
if not "%cd%"=="%~dp0releng\org.eclipse.papyrus.information.modeling.product\target\products" (
    echo Error: No se pudo cambiar a la ruta especificada.
    pause
    exit /b 1
)

REM Descomprimir el archivo ZIP
set ZIP_FILE=org.eclipse.papyrus.information.modeling.product-win32.win32.x86_64.zip
if exist %ZIP_FILE% (
    powershell -command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath ."
    echo Archivo descomprimido exitosamente.
) else (
    echo El archivo %ZIP_FILE% no existe.
    pause
    exit /b 1
)

@REM REM Volver al directorio raíz
@REM cd %~dp0

@REM REM Copiar la carpeta org.eclipse.osgi a la ruta especificada
@REM set SOURCE_DIR=assets\org.eclipse.osgi
@REM set DEST_DIR=releng\org.eclipse.papyrus.information.modeling.product\target\products\DEA\configuration

@REM if exist %SOURCE_DIR% (
@REM     robocopy %SOURCE_DIR% %DEST_DIR%\org.eclipse.osgi /E
@REM     if %errorlevel% geq 8 (
@REM         echo Error: No se pudo copiar la carpeta org.eclipse.osgi.
@REM         pause
@REM         exit /b %errorlevel%
@REM     )
@REM     echo Carpeta org.eclipse.osgi copiada exitosamente.
@REM ) else (
@REM     echo La carpeta %SOURCE_DIR% no existe.
@REM     pause
@REM     exit /b 1
@REM )