#!/bin/sh
#Algo2Tester version 1.1
#Repositorio de github: https://github.com/lima-limon-inc/TesterAlgo2


if [ ! -f "go.mod" ]
then
	echo "
No te olvides de que en go hay que iniciar el modulo (sea lo que sea que eso signifique). 
"
	while true; do 
		read -p "Queres que te ayude a crearlo? (si|no)" rta
		case $rta in
			[nN]o)
				echo "
Joya, volve cuando lo tengas todo listo entonces"
				exit 0 ;; #Paso 0 porque todo salio bien, el usuario decidio salir
			[sS]i)
				echo "Genial. Le voy a poner el nombre de la carpeta en la que estamos de nombre al modulo"
				echo "Creando modulo"
				modulo=$(basename $(pwd))
				go mod init $modulo
				echo "Hago go mod tidy (Por las dudas, nunca viene mal"
				go mod tidy
				if [ ! -f "../go.work" ]
				then
					echo "
Ah no, encima te falta el go.work en el directorio padre. Vos no hiciste nada de nada. Acordate la proxima de hacer 'go work init' en el directorio padre antes de empezar"
					echo "No te preocupues, ya lo hago yo por vos"
					( cd .. ; go work init )
				fi
				echo "Me voy al directorio padre, activo el modulo y vuelvo"
				( cd .. ; go work use $modulo )
				echo "Listo todo creado y toda la parte de los modulos 'hecha'
				"
				break;;
			* )
				echo "No entendi, por favor responde 'no' o 'si'"
		esac
	done
fi

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
