@echo off
REM Ejecutar mvn clean install con el perfil product
mvn clean install -Pproduct

REM Pausar para verificar el resultado del build
pause

REM Verificar si el build fue exitoso
if %errorlevel% neq 0 (
    echo Error: Fallo en la construcción del proyecto.
    pause
    exit /b %errorlevel%
)

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
    powershell -command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath .\extracted"
    echo Archivo descomprimido exitosamente.
) else (
    echo El archivo %ZIP_FILE% no existe.
)

pause