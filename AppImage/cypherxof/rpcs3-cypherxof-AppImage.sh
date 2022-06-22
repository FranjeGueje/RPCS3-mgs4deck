#! /bin/bash

#Actualizamos antes de nada
pacman -Suy --noconfirm

#Instalamos un entorno de compilación
pacman -Su wget bash-completion git cmake base-devel --noconfirm


#Ahora los paquetes mínimos para el software rpcs3
pacman -S glew openal cmake vulkan-validation-layers qt5-base qt5-declarative sdl2 qt5-multimedia qt5-svg --noconfirm

#Descargamos mediante git
git clone https://github.com/cipherxof/rpcs3.git -b patch-1 && cd rpcs3 && git submodule update --init
mkdir ../build && cd ../build/
cmake ../rpcs3 -DCMAKE_INSTALL_PREFIX=/usr -DUSE_NATIVE_INSTRUCTIONS=ON
 
 #Probar a forzar:
 #CC=gcc CXX=g++ CFLAGS="-O3 -march=znver2 -mtune=znver2" CXXFLAGS="-O3 -march=znver2 -mtune=znver2" cmake ../rpcs3 -DCMAKE_INSTALL_PREFIX=/usr -DUSE_NATIVE_INSTRUCTIONS=OFF


#Ya está preparado para compilar y compilamos
make 

#Generamos el ejecutable
make install DESTDIR=AppDir


########################################################
##    YA DEBEMOS DE TENER EL EJECUTABLE COMPILADO     ##
########################################################

#Nos descargamos la utilidad de creación de appImage
wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
chmod +x linuxdeploy-x86_64.AppImage


#Generamos la aplicación (el siguiente comando sería para uso normal). Lo omitimos porque....
  #./linuxdeploy-x86_64.AppImage --appdir AppDir

#Si estamos en dockers, por motivos de fuse no funciona: https://docs.appimage.org/user-guide/troubleshooting/fuse.html
#hay que extraer y ejecutar para cargar el anterior fichero de compactación

./linuxdeploy-x86_64.AppImage --appimage-extract-and-run --appdir=AppDir --output appimage

# Y wualá, ya lo tenemos
ls RPCS3-x86_64.AppImage

exit "$?"