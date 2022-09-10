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
	echo '''
$1 no existe :(
'''
	exit 2 #Paso 2 como error porque el usuario no paso un archivo existente
fi



echo "Dandole formato"
go fmt "$1.go"

echo "Compilando el programa a ejecutable"
go build -o "$1"

#echo "Comienzo del testeo"
#go test 
go version
