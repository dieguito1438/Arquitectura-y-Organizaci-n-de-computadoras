.data
# Strings para el usuario.

inicio: .asciiz "Calculadora\n"
operacion: .asciiz "¿Qué quieres hacer?\n"
suma: .asciiz "1. Sumar\n"
resta: .asciiz "2. Restar\n"
multiplicacion: .asciiz "3. Multiplicación\n"
division: .asciiz "4. División\n"
op: .asciiz "Operación: "
numero1: .asciiz "\nDame el primer número: "
numero2: .asciiz "\nDame el segundo número: "
resultado: .asciiz "\nEl resultado es: "
err: .asciiz "\nNo existe la operación solicitada "

.text
.globl main

main: 
li $v0 4 # Bienvenida del programa
la $a0 inicio
syscall 

menu: # Imprimimos el menu de las operaciones disponibles.
la $a0 operacion
syscall
la $a0 suma
syscall
la $a0 resta
syscall
la $a0 multiplicacion
syscall
la $a0 division
syscall

queOperacion: # Pedimos que el usuario seleccione una operación.
la $a0 op
syscall
la $v0 5
syscall # Recibimos el número del usuario.
move $a1 $v0

hayError: # Si el número recibido no es valido.
li $t1 1
li $t2 4
blt $a1 $t1 error
blt $a1 $t2 error

recibirNumeros: # Pedimos que el usuario escriba los números a operar.
la $v0 4
la $a0 numero1
syscall
la $v0 5
syscall # Recibimos el primer número
move $a2 $v0
la $v0 4
la $a0 numero2
syscall
la $v0 5
syscall # Recibimos el segundo número
move $a3 $v0

decidirOperacion: # Nos lleva a la operación a realizar.
beq $a1 2 rest
beq $a1 3 mu1t
beq $a1 4 d1v
# Si no es ninguna de ellas, solo pasamos a la suma.

sum: # Para sumar los números recibidos.
add $a1 $a2 $a3
j final

rest: # Para restar los números recibidos.
sub $a1 $a2 $a3
j final

mu1t: # Para multipliacr los números recibidos.
mul $a1 $a2 $a3
j final

d1v: # Para dividir los números recibidos.
div $a1 $a2 $a3

final: # Imprime el resultado de la operación y finaliza el programa.
la $a0 resultado
li $v0 4
syscall
move $a0 $a1
li $v0 1
syscall 
li $v0 10
syscall

error: # En caso que la operación solicitada no exista, y finaliza el programa.
li $v0 4
la $a0 err
syscall 
move $v0 $a1
li $v0 1
syscall
li $v0 10
syscall
