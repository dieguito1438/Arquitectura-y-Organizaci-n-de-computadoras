.data 
# Strings para el usuario.

inicio: .asciiz "Cociente y residuo\n"
numero1: .asciiz "Primer número: "
numero2: .asciiz "\nSegundo número: "
cociente: .asciiz "Cociente: "
residuo: .asciiz "\nResiduo: "

.text
.globl main

main: 
li $v0 4 
la $a0 inicio # Bienvenida del programa
syscall

recibirNumeros:
la $a0 numero1 # Pedimos el primer número.
syscall
li $v0 5
syscall # Recibimos el primer número.
move $a1 $v0
la $a0 numero2 # Pedimos el segundo número.
li $v0 4
syscall
li $v0 5
syscall # Recibimos el segundo número.
move $a2 $v0

bgt $a2 $a1 mayorQue # Si el número $a2 es mayor a $a1, no hay cociente, solo residuo.

# Cociente sera $v0
# residuo sera $v1

move $v1 $a1
li $v0 0

bucle:
blt $v1 $a2 final # Aun hay residuo para seguir restando?
sub $v1 $v1 $a2
addi $v0 $v0 1
j bucle

mayorQue: # Si desde la entrada no es posible restar.
la $a0 cociente # Imprimimos el cociente.
li $v0 4
syscall
move $a0 $zero
li $v0 1
syscall
la $a0 residuo # Imprimimos el residuo.
li $v0 4
syscall
move $a0 $a2
li $v0 1
syscall
li $v0 10 # Finalizamos el programa
syscall

final:
move $a1 $v0
la $a0 cociente # Imprimimos el cociente.
li $v0 4
syscall
move $a0 $a1
li $v0 1
syscall
la $a0 residuo # Imprimimos el residuo
li $v0 4
syscall
move $a0 $v1
li $v0 1
syscall
li $v0 10 # Finalizamos el programa.
syscall