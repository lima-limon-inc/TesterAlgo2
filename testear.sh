#!/bin/sh

echo "Dandole formato"
go fmt "$1.go"

echo "Compilando el programa a ejecutable"
go build -o "$1"

#echo "Comienzo del testeo"
#go test 
go version
