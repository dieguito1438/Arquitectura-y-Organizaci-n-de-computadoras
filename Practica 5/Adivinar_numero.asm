.data 
# Strings para el usuario.

msj: .asciiz "Ingrese el numero para adivinar: "
msj1: .asciiz "El numero es mayor \n"
msj2: .asciiz "El numero es menor \n"
msj3: .asciiz "Numero de intentos: "
msj4: .asciiz "Resultado correcto \n"

.text
.globl main

main:

li $t8, 1
li $t9, 0

li $v0, 42
li $a1, 11
syscall

move $t0, $a0


bucle:
add $t9, $t9, $t8

li $v0, 4
la $a0, msj
syscall

li $v0, 5
syscall
move $t1, $v0

beq $t0, $t1, fin
blt $t1, $t0, mayor
bgt $t1, $t0, menor

menor:
li $v0, 4
la $a0, msj2
syscall
j bucle

mayor:
li $v0, 4
la $a0, msj1
syscall
j bucle

fin:
li $v0, 4
la $a0, msj4
syscall
li $v0, 4
la $a0, msj3
syscall
li $v0, 1
move $a0, $t9
syscall

li $v0, 10
syscall
