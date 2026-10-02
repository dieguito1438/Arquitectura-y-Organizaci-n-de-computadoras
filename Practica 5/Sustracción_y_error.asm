.data
# Strings para el usuario.

inicio: .asciiz "Sustracción con error.\n"
numero1: .asciiz "Ingresa un numero: "
numero2: .asciiz "Ingresa otro numero: "
resultado: .asciiz "Resultado: "
msjerr: .asciiz "Se produjo un error"

.text
.globl main

main:
li $v0, 4 # Bienvenida del programa.
la $a0 inicio
syscall

recibimosNumeros:
la $a0, numero1
syscall
li $v0, 5 # Leemos el primer número del usuario.
syscall
move $t0, $v0
li $v0, 4
la $a0, numero2
syscall
li $v0, 5 # Leemos el segundo número del usuario.
syscall
move $t1, $v0

resta:
sub $t2, $t0, $t1
blt $t2, $zero, error # Si el número es negativo.
li $v0, 1
move $a0, $t2
syscall
j fin

error:
li $t2, 0
li $v0, 4
la $a0, msjerr
syscall

fin:
li $v0, 10
syscall

