.data 

bienvenida: .asciiz "Promedio de 5 double's\n"
numero: .asciiz "Escribe un número: "
resultado: .asciiz "\nResultado: "

numero5: .float 5.00

.text
.globl main

main:
li $v0 4 		# Bienvenida al programa.
la $a0 bienvenida
syscall

pedimosNumeros:
la $a0 numero		# Pedimos el primer número.
syscall
li $v0 6
syscall
mov.s $f1 $f0

li $v0 4			# Pedimos el segundo número.
syscall
li $v0 6
syscall
mov.s $f2 $f0

li $v0 4			# Pedimos el tercer número.
syscall
li $v0 6
syscall
mov.s $f3 $f0

li $v0 4			# Pedimos el cuarto número.
syscall
li $v0 6
syscall
mov.s $f4 $f0

li $v0 4			# Pedimos el quinto número.
syscall
li $v0 6
syscall
mov.s $f5 $f0

calcularPromedio:
add.s $f0 $f1 $f2	# Sumamos todos los valores en $f0.
add.s $f0 $f0 $f3
add.s $f0 $f0 $f4
add.s $f0 $f0 $f5

l.s $f6 numero5
div.s $f0 $f0 $f6	# Dividimos el resultado entre 5.

final:
la $a0 resultado		# Imprimimos el resultado.
li $v0 4
syscall
mov.s $f12 $f0
li $v0 2
syscall

li $v0 10
syscall