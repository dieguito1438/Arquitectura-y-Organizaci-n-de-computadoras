.data

bienvenida: .asciiz "Simulador de terminal\n"

buffer: .space 64
bufferLectura: .space 1024

comando: .asciiz "Terminal/Aqui$ "
error: .asciiz "Comando no implementado"

help: .asciiz "help"
mix: .asciiz "mix"
coin: .asciiz "coin"
song: .asciiz "song"
rev: .asciiz "rev"
cat: .asciiz "cat"
repr: .asciiz "repr"
syscall37: .asciiz "37"
syscall38: .asciiz "38"
exit: .asciiz "exit"

helpHelp: .asciiz "help [-arg-] \n Imprime información de los comandos disponibles\n y sus operaciones. Si se llama sin argumentos, imprime una lista de \n los comandos disponibles.\n"
helpMix: .asciiz "mix\n Muestra la recomendación de una canción.\n"
helpCoin: .asciiz "coin -int-\n Dado un número entero -int- se lanzaran ese número de \n monedas y mostrara el resultado\n"
helpSong: .asciiz "song\n Genera una canción (El intro de la canción Shymphony).\n"
helpRev: .asciiz "rev [-file-]\n Imprime la reversa de una cadena\n Si no se especifica un archivo, se utiliza la entrada estandar.\n"
helpCat: .asciiz "cat -file- [-file-]\n Concatena 2 archivos y los muestra en la pantalla.\n"
helpRepr: .asciiz "repr -int-\n Toma el número -int- e imprime su representación Hexadecimal, Binaria y Unsigned.\n"
helpExit: .asciiz "exit\n Finaliza la ejeciución de la terminal\n"
helpSyscall37: .asciiz "37\n Syscall 37. Calcula tu edad con tu año de nacimiento.\n"
helpSyscall38: .asciiz "38\n Syscall 38. Imprime un corazón en la consola <3.\n"
helpVoid: .asciiz "Comandos:\n help [-arg-]\n mix\n coin -int-\n song\n rev [-file-]\n cat -file- [-file-]\n repr -int-\n 37\n 38\n exit\n"
helpError: .asciiz "help -arg-\n Coomando -arg- invalido.\n"

mix1: .asciiz "Symphony, by Clean Bandit feat Zara Larsson.\n"
mix2: .asciiz "Life Boat, by RAYE.\n"
mix3: .asciiz "Warm, by Ariana Grande.\n"
mix4: .asciiz "HARRY STAMPER, by Humbe.\n"
mix5: .asciiz "One Last Time, by Ariana Grande.\n"
mix6: .asciiz "Cindy Lou Who, by Sabrina Catpenter.\n"
mix7: .asciiz "Don't Smile, by Sabrina Carpenter.\n"
mix8: .asciiz "Me gusta un chico, by David Rees.\n"
mix9: .asciiz "Boys Beware, by Mad Tsai.\n"
mix10: .asciiz "Chasing Cars, by Snow Patrol.\n"
mix11: .asciiz "Click Clack Shymphony, by RAYE feat Hans Zimmer\n"

moneda: .asciiz "Moneda "
aguila: .asciiz ": Aguila\n"
sol: .asciiz ": Sol\n"
coinError: .asciiz "Falta el -int- número de monedas que lanzar como argumento para coin\n"

revEntrada: .asciiz "Ingrese la cadena: "
revError: .asciiz "Error al abrir el archivo.\n"

finCat: .asciiz "\n--- Fin del archivo ---\n"
catError: .asciiz "No se puede abrir el archivo\n"
catErrorArgs: .asciiz "Falta el -file- como argumento para cat\n"

hexadecimal: .asciiz "Hexadecimal: "
binario:     .asciiz "Binario    : "
unsigned:    .asciiz "Unsigned   : "
reprError: .asciiz "Falta el -int- como argumento para repr\n"

salida: .asciiz "Seguro que quieres salir?"

ingresarAño: .asciiz "Ingrese su año de nacimiento: "
resultadoEdad: .asciiz "Su edad es: "

corazon: .asciiz "\n  *** *** \n ***** ***** \n*************\n *********** \n  ********* \n   ******* \n    ***** \n     *** \n      * \n"

# Syscall 37
.macro sys37
	la $a0 ingresarAño		# Solicitamos el año al usuario
	li $v0 4
	syscall

	li $v0 5
	syscall
	li $t0 2026

	sub $a0 $t0 $v0			# Le restamos el año del usuario a 2026

	move $t1 $a0			# Imprimimos el resultado
	la $a0 resultadoEdad
	li $v0 4
	syscall

	move $a0 $t1
	li $v0 1
	syscall
	li $a0 10
	li $v0 11
	syscall
.end_macro

# macro 38
.macro sys38
	la $a0 corazon			# Imprimimos el corazon <3.
	li $v0 4
	syscall
.end_macro


.text
.globl main

main:
la $a0 bienvenida			# Le damos la bienvenida al programa
li $v0 4
syscall

recibirComando:				# Loop constante para recibir los comandos del usuario.
la $a0 comando
li $v0 4
syscall
la $a0 buffer
li $a1 64
li $v0 8
syscall

# Buscamos a que comando se parece  la cadena ingresada por el usuario
compararComando:
la $s2 buffer
la $s3 help
jal compararStrings
beq $v1 1 helpt

la $s2 buffer
la $s3 mix
jal compararStrings
beq $v1 1 mixt

la $s2 buffer
la $s3 coin
jal compararStrings
beq $v1 1 coint

la $s2 buffer
la $s3 song
jal compararStrings
beq $v1 1 songt

la $s2 buffer
la $s3 rev
jal compararStrings
beq $v1 1 revt

la $s2 buffer
la $s3 cat
jal compararStrings
beq $v1 1 catt

la $s2 buffer
la $s3 repr
jal compararStrings
beq $v1 1 reprt

la $s2 buffer 
la $s3 syscall37
jal compararStrings
beq $v1 1 syscall37t

la $s2 buffer 
la $s3 syscall38
jal compararStrings
beq $v1 1 syscall38t

la $s2 buffer
la $s3 exit
jal compararStrings
beq $v1 1 exitt

# No se ingreso ningun comando disponible
j errort


compararStrings:
lb $t2 ($s2)
lb $t3 ($s3)
beq $t3 $zero verificarFinUsuario

bne $t2 $t3 compararNe

addi $s2 $s2 1
addi $s3 $s3 1
j compararStrings

verificarFinUsuario:
lb $t2 ($s2)
beq $t2 10 compararEq
beq $t2 0 compararEq
beq $t2 32 saltarBlanco

j compararNe

saltarBlanco:
li $v1 1
jr $ra

# Las cadenas son diferentes
compararNe:
li $v1 0
jr $ra

# Las cadenas son iguales
compararEq:
li $v1 1
jr $ra


# El comando ingresado por el usuario es invalido
errort:
la $a0 error
la $a1 0
li $v0 55
syscall
j recibirComando


# El usuario ingreso el comando help
helpt:
lb $t4 ($s2)

beq $t4 10 helpVacio
beq $t4 32 helpArgumentado
j helpVacio

# help sin argumentos
helpVacio:
la $a0 helpVoid
li $v0 4
syscall 
j recibirComando

# Help con un argumentos
helpArgumentado:
addi $s2 $s2 1
move $s4 $s2

# Que comando el usuario quiere conocer?
la $s3 help
jal compararStrings
beq $v1 1 helpInfo

move $s2 $s4
la $s3 mix
jal compararStrings
beq $v1 1 mixHelp

move $s2 $s4
la $s3 coin
jal compararStrings
beq $v1 1 coinHelp

move $s2 $s4
la $s3 song
jal compararStrings
beq $v1 1 songHelp

move $s2 $s4
la $s3 rev
jal compararStrings
beq $v1 1 revHelp

move $s2 $s4
la $s3 cat
jal compararStrings
beq $v1 1 catHelp

move $s2 $s4
la $s3 repr
jal compararStrings
beq $v1 1 reprHelp

move $s2 $s4
la $s3 syscall37
jal compararStrings
beq $v1 1 syscall37Help

move $s2 $s4
la $s3 syscall38
jal compararStrings
beq $v1 1 syscall38Help

move $s2 $s4
la $s3 exit
jal compararStrings
beq $v1 1 exitHelp

# El usuario no ingreso unc comando valido
j errorHelp

errorHelp:
la $a0 helpError
li $v0 4
syscall
j recibirComando

helpInfo:
la $a0 helpHelp
la $v0 4
syscall
j recibirComando

mixHelp:
la $a0 helpMix
la $v0 4
syscall
j recibirComando

coinHelp:
la $a0 helpCoin
la $v0 4
syscall
j recibirComando

songHelp:
la $a0 helpSong
la $v0 4
syscall
j recibirComando

revHelp:
la $a0 helpRev
la $v0 4
syscall
j recibirComando

catHelp:
la $a0 helpCat
la $v0 4
syscall
j recibirComando

reprHelp:
la $a0 helpRepr
la $v0 4
syscall
j recibirComando

syscall37Help:
la $a0 helpSyscall37
la $v0 4 
syscall
j recibirComando

syscall38Help:
la $a0 helpSyscall38
la $v0 4 
syscall
j recibirComando

exitHelp:
la $a0 helpExit
la $v0 4
syscall
j recibirComando


# El usuario ingreso el comando mix
mixt:
li $a1 11
li $v0 42
syscall
beq $a0 0 cancion1
beq $a0 1 cancion2
beq $a0 2 cancion3
beq $a0 3 cancion4
beq $a0 4 cancion5
beq $a0 5 cancion6
beq $a0 6 cancion7
beq $a0 7 cancion8
beq $a0 8 cancion9
beq $a0 9 cancion10
beq $a0 10 cancion11

cancion1:
la $a0 mix1
j imprimirCancion

cancion2:
la $a0 mix2
j imprimirCancion

cancion3:
la $a0 mix3
j imprimirCancion

cancion4:
la $a0 mix4
j imprimirCancion

cancion5:
la $a0 mix5
j imprimirCancion

cancion6:
la $a0 mix6
j imprimirCancion

cancion7:
la $a0 mix7
j imprimirCancion

cancion8:
la $a0 mix8
j imprimirCancion

cancion9:
la $a0 mix9
j imprimirCancion

cancion10:
la $a0 mix10
j imprimirCancion

cancion11:
la $a0 mix11
j imprimirCancion

imprimirCancion:
li $v0 4
syscall
j recibirComando


# El usuario ingreso el comando coin
coint:
move $t1 $s2

saltarEspacio:
lb $t2 ($t1)
beq $t2 32 saltarUno
j verificarVacio

saltarUno:
addi $t1 $t1 1
j saltarEspacio


verificarVacio:
beq $t2 10 errorCoin
beq $t2 $zero errorCoin
li $t0 0

convertirLoop:
lb $t2 ($t1)
beq $t2 10 coinLanzamiento
beq $t2 $zero coinLanzamiento

subi $t2 $t2 48
mul $t0 $t0 10
add $t0 $t0 $t2
addi $t1 $t1 1
j convertirLoop

coinLanzamiento:
bgtz $t0 coinloop
j errort

coinloop:
blez $t0 recibirComando

la $a0 moneda
li $v0 4
syscall
move $a0 $t0
li $v0 1
syscall
li $a1 2
li $v0 42
syscall
beq $a0 0 monedaAguila

monedaSol:
la $a0 sol
li $v0 4
syscall
j siguienteCoin

monedaAguila:
la $a0 aguila
li $v0 4
syscall

siguienteCoin:
subi $t0 $t0 1
j coinloop

errorCoin: 
la $a0 coinError
li $v0 4
syscall
j recibirComando

# El usuario ingreso el comando song
# Intentamos hacer el intro de la canción Symphony (Como amo esa canción).
songt:
li $v0 33	# MIDI out synchronous
li $a2 1		# instrument
li $a3 100
# si5 bemol 
li $a0 79
li $a1 250		# duracion
syscall

# silencios
syscall
li $v0 32
li $a0 500
syscall

# mi5 bemol
li $a3 100
li $a1 250
li $a0 75
li $a2 1
li $v0 33
syscall

# silencio
li $v0 32
li $a0 500
syscall

# la 5 y Mi 5 bemol
li $a0 80
li $a1 250
li $a2 1
li $a3 100
li $v0 31
syscall

li $a0 75
li $v0 33
syscall

# Silencio
li $a0 500
li $v0 32
syscall

# Sol 5 y Si 4 bemol
li $a0 79
li $a1 2000
li $v0 31 
syscall

li $a0 70
li $v0 33
syscall

# Silencio
li $a0 250
li $v0 32
syscall

# Si 5 bemol y Re 5
li $a0 80
li $a1 125
li $v0 31
syscall

li $a0 74
li $v0 33
syscall

# Do 6 y Mi 5 bemol
li $a0 84
li $v0 31
syscall

li $a0 75
li $v0 33
syscall

# Re 6 y Si 4 bemol
li $a0 87
li $a1 1750
li $v0 31
syscall

li $a0 75
li $v0 33
syscall

# Sol 6 y Sol 5
li $a0 91
li $a1 250
li $v0 31
syscall

li $a0 79
li $v0 33
syscall

# Re 6 y Re 5
li $a0 86
li $a1 1250
li $v0 31
syscall

li $a0 74
li $v0 33
syscall

# Sol 5 y Sol 4
li $a0 79
li $a1 250
li $v0 31
syscall

li $a0 67
li $v0 33
syscall

# Si 5 bemol y Si 4 bemol
li $a0 82
li $v0 31
syscall

li $a0 70
li $v0 33
syscall

# Mi 6 bemol y Mi 5 bemol
li $a0 87
li $v0 31
syscall
li $a0 75
li $v0 33
syscall

# Do 6 y Do 5
li $a0 84
li $a1 4000
li $v0 31
syscall

li $a0 72
li $v0 33
syscall
    
j recibirComando

# El usuario ingreso el comando revt
revt:
move $t1 $s2
lb $t2 ($t1)

beq $t2 10 revEntradaEstandar
beq $t2 $zero revEntradaEstandar

saltarEspacios:
lb $t2 ($t1)
bne $t2 32 revArchivo
addi $t1 $t1 1
j saltarEspacios

revArchivo:
move $a0 $t1
jal limpiarEntrada

li $v0 13
li $a1 0
li $a2 0
syscall
move $s0 $v0

bltz $s0 errorRev

li $v0 14
move $a0 $s0
la $a1 buffer
li $a2 64
syscall

li $v0 16
move $a0 $s0
syscall

la $t1 buffer
j buscarFinal

revEntradaEstandar:
la $a0 revEntrada
li $v0 4
syscall
la $a0 buffer
li $a1 64
li $v0 8
syscall
la $t1 buffer

buscarFinal:
lb $t2 ($t1)
beq $t2 10 finEncontrado
beq $t2 $zero finEncontrado
addi $t1 $t1 1
j buscarFinal

finEncontrado:
subi $t1 $t1 1

imprimirRev:
la $t3 buffer
blt $t1 $t3 finalizarRev
lb $a0 ($t1)
li $v0 11
syscall
subi $t1 $t1 1
j imprimirRev

finalizarRev:
li $a0 10
li $v0 11
syscall
j recibirComando

errorRev:
la $a0 revError
li $v0 4
syscall
j recibirComando

limpiarEntrada:
lb $t8 ($a0)
beq $t8 10 ponerCero
beq $t8 $zero regresarRev
addi $a0 $a0 1
j limpiarEntrada

ponerCero:
sb $zero ($a0)
regresarRev:
jr $ra


# El usuario ingreso el comando cat
catt:
move $t1 $s2

primerEspacio:
lb $t2 ($t1)
beq $t2 10 errorCatArgs
beq $t2 $zero errorCatArgs
beq $t2 32 encontrar1
addi $t1 $t1 1
j primerEspacio

errorCatArgs:
la $a0 catErrorArgs
li $v0 4
syscall
j recibirComando

encontrar1:
addi $t1 $t1 1
move $s6 $t1

separador:
lb $t2 ($t1)
beq $t2 10 unArchivo
beq $t2 32 dosArchivos
addi $t1 $t1 1
j separador

unArchivo:
sb $zero ($t1)
move $a0 $s6
jal imprimirCat
j recibirComando

dosArchivos:
sb $zero ($t1)
addi $t1 $t1 1
move $s7 $t1

move $a0 $s7
jal limpiarEntrada

move $a0 $s6
jal imprimirCat
move $a0 $s7
jal imprimirCat
j recibirComando

imprimirCat:
move $t9 $a0
li $v0 13
move $a0 $t9
li $a1 0
li $a2 0
syscall
move $s0 $v0

bltz $s0 errorCat

li $v0 14
move $a0 $s0
la $a1 bufferLectura
li $a2 1024
syscall
move $t8 $v0

la $t4 bufferLectura
add $t4 $t4 $t8
sb $zero ($t4)

li $v0 4
la $a0 bufferLectura
syscall

li $v0 16
move $a0 $s0
syscall
jr $ra

errorCat:
la $a0 catError
li $v0 4
syscall
jr $ra


# El usuario ingreso el comando repr
reprt:
move $t1 $s2

saltarEspaciosRepr:
lb $t2 ($t1)
beq $t2 32 saltarUnoRepr
j verificarVacioRepr

saltarUnoRepr:
addi $t1 $t1 1
j saltarEspaciosRepr

verificarVacioRepr:
lb $t2 ($t1)
beq $t2 10 errorRepr
beq $t2 $zero errorRepr

li $t0 0
li $t9 0

convertirRepr:
lb $t2 ($t1)
beq $t2 10 imprimirRepr
beq $t2 $zero imprimirRepr
beq $t2 32 imprimirRepr

blt $t2 48 imprimirRepr
bgt $t2 57 imprimirRepr

subi $t2 $t2 48
mul $t0 $t0 10
add $t0 $t0 $t2
addi $t1 $t1 1
li $t9 1
j convertirRepr

errorRepr:
la $a0 reprError
li $v0 4
syscall
j recibirComando

imprimirRepr:
beq $t9 $zero errorRepr
move $s5 $t0

li $a0 10
li $v0 11
syscall
la $a0 hexadecimal
li $v0 4 
syscall
move $a0 $s5
li $v0 34
syscall

li $a0 10
li $v0 11
syscall
la $a0 binario
li $v0 4
syscall
move $a0 $s5
li $v0 35
syscall

li $a0 10
li $v0 11
syscall
la $a0 unsigned
li $v0 4
syscall
move $a0 $s5
li $v0 36
syscall

li $a0 10
li $v0 11
syscall
j recibirComando


# El usuario ingreso el comando 37
syscall37t:
sys37
j recibirComando


# El usuario ingreso el comando 38
syscall38t:
sys38
j recibirComando


# El usuario ingreso el comando exit
exitt:
la $a0 salida
li $v0 50
syscall
bne $a0 $zero recibirComando

end:
li $v0 10
syscall