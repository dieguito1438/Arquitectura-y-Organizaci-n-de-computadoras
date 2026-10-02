.data
# Strings para el usuario.

inicio: .asciiz "Imprimir n veces un mensaje.\n"
msj: .asciiz "Ingresa numero (positivo) de veces: "
msj1: .asciiz "Hola mundito y asi\n"

.text
.globl main

main:
li $v0 4 # Bienvenida del programa.
la $a0 inicio 
syscall

solicitarNumero:
la $a0 msj
syscall
li $v0 5 # Solicitamos el número de veces que se va a repetir el mensaje
syscall
li $t0 0
move $t2, $v0
la $a0, msj1

bucle: # Bucle de repetición.
beq $t0, $t2, fin # Salida.
li $v0, 4 
syscall
addi $t0, $t0, 1
j bucle

fin:
li $v0, 10 # Fin del programa.
syscall
