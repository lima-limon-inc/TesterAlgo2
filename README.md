# Tester de Algoritmos 2
## Que hace?
Mini mini Shell script que lo podes correr 1 sola vez y logra:
- Formatear tu programa
- Compilarlo
- Testearlo

## Como usarlo?
Una vez descargado tenes que correr:
```
chmod u+x testear.sh
```
- chmod: Comando de Linux/UNIX que le cambia los permisos a un archivo
- u: **U**suario, lo que le sigue solo va a aplicar al usuario y a ningun otro grupo
- +x: Añade permiso de ejecucion
- tester.sh: El archivo al que queremos aplicarle todo lo de arriba

Para testear que quedo todo bien pueden correr 
```
ls -l
```
Y deberia verse algo asi:
> -rwx------ 1 usuario grupo peso fecha testear.sh

Con una "x" en la 4ta posicion del primer campo. Si ademas tienen "x" en alguna otra posicion, tambien deberia funcionar

## TODO
Cosas que quedan por hacer
- [ ] Que el programa se encarge de toda la parte de go mod, lo del go work y eso
