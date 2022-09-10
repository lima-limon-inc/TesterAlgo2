#!/bin/sh
if [ -z "$1" ]
then
	echo '''
Tenes que pasar un archivo como primer parametro para que el programa funcione.
Ejemplo: ./testear.sh hola_mundo.go
'''
	exit 2 #Paso 2 como error porque el usuario no paso los archivos necesarios
fi

if [ ! -f "$1" ]
then
	echo #No me gusta nada este echo vacio, lo puse porque no se como lograr usar un echo ''' que pueda imprimir la primera variable pasada al programa $1. Pull requests mas que bienvenidos
	echo $1 no existe
	echo
	exit 2 #Paso 2 como error porque el usuario no paso un archivo existente
fi

if [ ".go" != $(echo -n $1 | tail -c 3) ]
then
	echo '''
Tenes que pasarme un archivo ".go"
	'''
	exit 2 #Paso 2 como error porque el usuario no paso un archivo existente
fi

sinExtension=${1:: -3} #Creo una variable del archivo a compilar sin la extension para facilitar los comandos que le siguen


echo "Dandole formato"
go fmt "$1"

echo "Compilando el programa a ejecutable"
go build -o "$sinExtension"

if [ ! -f "${sinExtension}_test.go" ]
then
	echo #No me gusta nada este echo vacio, lo puse porque no se como lograr usar un echo ''' que pueda imprimir la primera variable pasada al programa $1. Pull requests mas que bienvenidos
	echo "No hay ningun archivo de testeo. Algo del estilo de ${sinExtension}_test.go"
	echo
	exit 2 #Paso 2 como error porque el usuario no paso un archivo sin un test asociado a ese
fi

#echo "Comienzo del testeo"
#go test
go version
