#! /bin/bash

# Descargamos el proyecto de creación desde flathub
git clone https://github.com/flathub/net.rpcs3.RPCS3.git

# Entramos al directorio y actualizamos los submódulos
cd net.rpcs3.RPCS3
git submodule update --init

# Renombramos el fichero yaml
cp net.rpcs3.RPCS3.yaml net.rpcs3.RPCS3-SD.yaml

# Modificamos el ymal para añadir el cambio del nombre de aplicación
sed -i 's/net.rpcs3.RPCS3/net.rpcs3.RPCS3-SD/g' "net.rpcs3.RPCS3-SD.yaml"
sed -i 's/-O2/-O3 -march=native -mtune=native/g' "net.rpcs3.RPCS3-SD.yaml"
sed -i 's/DUSE_NATIVE_INSTRUCTIONS=OFF/DUSE_NATIVE_INSTRUCTIONS=ON/g' "net.rpcs3.RPCS3-SD.yaml"
sed -i 's/X86/host/g' "net.rpcs3.RPCS3-SD.yaml"
sed -i 's/RelWithDebInfo/Release/g' "net.rpcs3.RPCS3-SD.yaml"


# Creamos el repositorio con directorio "app" y las compilaciones en build
flatpak-builder --repo=app build net.rpcs3.RPCS3-SD.yaml

echo Revisa si han aparecido errores.
exit 0

