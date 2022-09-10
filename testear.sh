#!/bin/sh
#Algo2Tester version 1.0
#Repositorio de github: https://github.com/lima-limon-inc/TesterAlgo2


if [ -z "$1" ]
then
	echo "
Tenes que pasar un archivo como primer parametro para que el programa funcione.
Ejemplo: ./testear.sh hola_mundo.go
"
	exit 2 #Paso 2 como error porque el usuario no paso los archivos necesarios
fi

if [ ! -f "$1" ]
then
	echo " 
${1} no existe
	"
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
	echo "
No pude testear :(
No hay ningun archivo de testeo. Necesito algo del estilo de ${sinExtension}_test.go
	"
	exit 2 #Paso 2 como error porque el usuario no paso un archivo sin un test asociado a ese
fi

echo "Comienzo del testeo"
go test ${sinExtension}_test.go
