#!/bin/sh
#Algo2Tester version 1.6
#Repositorio de github: https://github.com/lima-limon-inc/TesterAlgo2

#Variables (0 = si, 1 = no)
opciones=":snhu" #Todas las flags que se le pueden pasar al programa
silent=1 #Si silent == 0, entonces queremos que el programa produzca la menor cantidad de texto. Si alguien tiene una solucion mas elegante esta mas que bienvenida
testear=0 #Si testear == 0, entonces el codigo se va a pasar por el testeo, si es igual a 1, entonces no se testea. Solo lo formatea y lo compila. Similar a un go run
unico=1 #Si unico == 0, entonces solo se va a formatear el archivo que pasa el usuario, sino se formatean todos los archivos


Print () {
	if [ $silent -eq 0 ] #Si se cumple esta condicion no queremos que se imprima nada
	then
		return 0
	fi
	echo "$1"
}

Help () {

echo "
Algo2Tester. Programa 'wrapper' del compilador de go y todas sus peculiaridades.

Formato de los comandos:
testear.sh -opciones archivo.go

Opciones disponibles: (En la version actual no se pueden combinar y usar mas de una)
-h: Help, Ayuda
-n: NO testear, simplemente se formatea y compila el cogigo. Similar a un go run (pero no lo ejecuta)
-s: SILENCIOSO: Da menos output a la pantalla
-u: UNICAMENTE: Unicamente formatea el archivo que te paso, no todos los .go del directorio. (No es altamente recomendado, no se gana mucho tiempo y nunca esta de mas 'volver a formatear' un archivo ya formateado
"
	exit 0 #Salgo deel programa porque el usuario pidio ver la ayuda
}


while getopts $opciones opt
do
	case "${opt}" in
	s) silent=0 ;;
	n) testear=1;;
	u) unico=0;;
	h | help ) Help ;;
	\?) echo "Opcion desconocida $OPTARG"; exit 1 ;;
	esac
	shift
done


if [ 18 -gt $(go version | cut -d " " -f 3 | cut -d "." -f 2) ]
then
	echo "Cuidado, para la materia de algoritmos 2 con Buchwald necesitas un version de Go mayor o igual a 1.18"
	echo "Tu version es:"
	go version
fi

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
				Print "Genial. Le voy a poner el nombre de la carpeta en la que estamos de nombre al modulo"
				Print "Creando modulo"
				modulo=$(basename $(pwd))
				go mod init $modulo
				Print "Ejecuto go mod tidy (Por las dudas, nunca viene mal"
				go mod tidy
				if [ ! -f "../go.work" ]
				then
					Print "
Ojo, tene cuidado que te falta archivo go.work en el directorio padre. Eso normalmente se hace ejecutando 'go work init' en el directorio padre"
					Print "No te preocupues, ya lo hago yo por vos"
					( cd .. ; go work init )
				fi
				Print "Me voy al directorio padre, activo el modulo y vuelvo"
				( cd .. ; go work use $modulo )
				Print "Listo todo creado y toda la parte de los modulos hecha"
				break;;
			* )
				echo "Disculpame, no entendi, por favor responde 'no' o 'si'"
		esac
	done
fi

if [ -z "$1" ]
then
	echo "
Ojo, tenes que pasar un archivo como primer parametro para que el programa funcione.
Ejemplo: testear.sh hola_mundo.go
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

Print "Dandole formato a "$1""
go fmt "$1"

if [ $unico -eq 1 ]
then
	for f in ./"$sinExtension"?*.go; do #Matchea todos los archivos que no son el archivo pasado
		Print "Dandole formato a "$f""
		go fmt "$f"
	done
fi

Print "Compilando "$1" a ejecutable"
go build "$sinExtension"

# De aca para abajo tiene que ver con el testeo del programa
if [ $testear -eq 1 ]
then
	exit 0 #Paso 0 porque el usuario decidio no testear
fi

if [ ! -f "${sinExtension}_test.go" ]
then
	echo "
No pude testear :(
No hay ningun archivo de testeo. Necesito algo del estilo de ${sinExtension}_test.go
	"
	exit 2 #Paso 2 como error porque el usuario no paso un archivo sin un test asociado a ese
fi

Print "Comienzo del testeo"
go test ${sinExtension}_test.go
