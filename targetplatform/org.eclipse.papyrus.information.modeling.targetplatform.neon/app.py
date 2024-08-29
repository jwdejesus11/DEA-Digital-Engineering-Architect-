import os

# Ruta al archivo routes.txt
routes_file_path = os.path.join(os.path.dirname(__file__), 'routes.txt')

# Leer la primera línea del archivo routes.txt
with open(routes_file_path, 'r') as file:
    first_line = file.readline().strip()

# Ruta al archivo de definición de target
target_file_path = os.path.join(os.path.dirname(__file__), 'org.eclipse.papyrus.information.modeling.targetplatform.neon.target')

# Leer el contenido del archivo de definición de target
with open(target_file_path, 'r') as file:
    target_content = file.read()

# Reemplazar la ruta en el archivo de definición de target
new_target_content = target_content.replace(
    'file:first-route',
    f'file:{first_line}'
)

# Guardar el archivo de definición de target actualizado
with open(target_file_path, 'w') as file:
    file.write(new_target_content)

print("Archivo de definición de target actualizado con la nueva ruta.")