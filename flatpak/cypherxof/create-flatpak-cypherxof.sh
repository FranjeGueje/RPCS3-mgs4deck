#! /bin/bash

# Creamos el repositorio con directorio "app" y las compilaciones en build
flatpak-builder --repo=app build net.rpcs3.RPCS3-cypherxof.yaml

echo Revisa si han aparecido errores.
exit 0

