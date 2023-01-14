****Instalador MyFacturasPlus Desktop****

Para generar el instalador del sistema es necesario instalar lo siguiente en un ambiente de windows:

1) Instalar Nsis

Para generar el instalador del sistema es necesario seguir los siguientes pasos:

1) Crear una carpeta con el nombre "bin". 
	La carpeta debe contener todos los archivos generados en Visual Studio al momento de compilar
	el proyecto.
	(Los cambios deben de estar previamente liberados por algun operativo de la empresa)

2) Modificar en el archivo "myacturas_installer.nsis" lo siguiente:
	MAJOR_VERSION: asigna el maximo de la versión del instaldor.
	MINOR_VERSION: asigna el minimo de la versión del instaldor.
	REVISION_VERSION: asigna el número de revisión del instaldor.
	(la versión del instalador va en sintonia de la versión que se agrega en la ventana login del sistema)

NOTA: El instalador ".exe" se debe subir a la carpeta compartida (Google Drive) de la empresa dentro de TimbradoSife/MyFacturas

