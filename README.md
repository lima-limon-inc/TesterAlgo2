# Tester de Algoritmos 2
## Que hace?
Mini mini Shell script que lo podes correr 1 sola vez y logra:
- Formatear tu programa
- Compilarlo
- Testearlo

## Como usarlo?
Recomiendo tener alguna carpeta el directorio home (el directorio donde "arranca" el shell, tambien abreviado como "~") llamado "Scripts". Para el resto de la guia voy a usar la direccion `~/Scripts` como ejemplo. Si te guardas el archivo en algun otro lado reemplaza
### Paso 1: Descargar archivo de Github
#### Manera 1: La vieja confiable: Ctrl+C; Ctrl+V
Create una carpeta "TesterAlgo2" en tu directorio de Scripts. Si seguiste lo recomendado podes ejecutar el siguiente comando:
```
mkdir ~/Scripts/TesterAlgo2
```
Una vez creada la carpeta, simplemente copia y pega el archivo testear.sh del directorio de Github ahi dentro. Despues copialo y pegalo en lo(s) directorios que vos necesites. 
**Advertencia**: Si lo haces de esta manera no vas a poder actualizar facilmente con git
#### Manera 2: Usando git clone (recomendado)
**Advertencia**: Para este metodo necesitas tener [git](https://es.wikipedia.org/wiki/Git) instalado en tu computadora. Pero no hace falta que sepas usarlo; solo necesitas correr **2** comandos.

Anda a la carpeta de scripts. Si seguiste la guia podes ejecutar el siguiente comando:
```
cd ~/Scripts
``` 
Una vez ahi dentro ejecuta el siguiete comando:
```
git clone https://github.com/lima-limon-inc/TesterAlgo2.git
```
Eso deberia crear una carpeta TesterAlgo2 en tu carpeta Scripts/.
Una vez hecho eso, entra a la carpeta TesterAlgo2

Lo que tiene de bueno este metodo es que podes actualizar el programa facilmente:
1. Anda a la carpeta donde tenes el programa (`cd ~/Scripts/TesterAlgo2`)
2. Corre el siguiente comando:
```
git fetch
```
Este comando actualiza el programa si hubo alguna actualizacion en Github

### Paso 2: Hacer el archivo ejecutable
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

### Paso 3:
Listo \:D/
Lo unico que necesitas hacer es copiar el archivo testear.sh en el directorio donde tengas tus arhchivos y ya esta.

#### Paso 3.5: Hacer el archivo ejecutable sin necesidad de copiarlo en todos lados (recomendado)
Podes hacer que el programa sea accesible desde cualquier lado de tu computadora si necesidad de copiar y pegar el archivo.
Simplemente tenes que añadir la carpeta donde tenes el programa al PATH.

**Advertencia**: Si tu sistema usa alguna otra shell como la Z shell (este es el caso en las Macs) entonces vas a tener que modificar el archivo rc (run commands) de tu shell. Si tenes un archivo `~/.bashrc` entonces tu sistema usa la shell de bash y no tenes de que preocuparte

1. Tenes que editar el archivo (~/.bashrc) usando tu editor de texto preferido. 
2. Una vez abierto, añadi al final del archivo (sin romper/tocar lo que ya esta escrito ahi, apreta enter(s) para ir a una linea nueva) las siguientes lineas. **Advertencia**: Si usaste alguna otra carpeta en el Paso 1, reemplazala como corresponda
```
# Modificaciones del PATH 
export PATH="${PATH}:$HOME/Scripts/Algo2Tester/:$PATH" #Programa para Algo 2 con Buchwald para facilitar el testeo de mis programas
```
3. Guarda y cerra el archivo
4. En la terminal corre el siguiente comando: 
```
source ~/.bashrc
```
5. Listo, si todo funciono bien, podes usar el comando `testear.sh` en cualquier lado
## TODO
Cosas que quedan por hacer
- [ ] Que el programa se encarge de toda la parte de go mod, lo del go work y eso
- [ ] Hacer que el programa chequee que tenes una version de go mayor a 1.18
- [ ] Anadir una flag de "modo silencioso"
- [ ] Anadir una flag de "no testear"
- [ ] Anadir un --help
