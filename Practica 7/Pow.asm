.data

bienvenida: .asciiz "Pow (elevar un número x a su n-esima potencia)\n"
numero1: .asciiz "Ingrese un número: "
numero2: .asciiz "Ingrese el número de la potencia: "
resultado: .asciiz "El resultado es: "
uno: .float 1e0

.text
.globl main

main: 
li $v0 4				# Bienvenida del programa.
la $a0 bienvenida
syscall

ingresarNumeros:
la $a0 numero1
syscall
li $v0, 6
syscall				# $f0 tendra el valor de la x. (Un float)
li $v0 4
la $a0 numero2
syscall
li $v0, 5
syscall
move $a1 $v0			# $a1 tendra el valor de la n. (Un integer)
jal pow				# Llamada a la subrutina.

fin:				# Imprimimos el resultado
li $v0 4
la $a0  resultado
syscall
cvt.w.s $f0 $f12			# El resultado esta en $f12 como un float, lo convertimos a integer
mfc1 $a0 $f0
li $v0 1
syscall
li $v0 10			# Finalizamos el programa.
syscall

pow:				# Subrutina
# Preambulo
addi $sp, $sp, -4		# Creamos un arreglo de tamaño 4
sw $ra 0($sp)  			# Guardamos en el arreglo[1] = $ra

bgtz $a1 powRecursion		# Si $a1 es mayor a 0, hacemos recursión.
l.s $f12 uno			# En el caso base que $a1 es menor o igual a 0, el resultado es 1.
j powRegreso

powRecursion:
sub $a1 $a1 1			# Disminuimos el contador
jal pow

mul.s $f12 $f12 $f0		# Multiplicamos x por (x a la n-1)

powRegreso:	
lw $ra, 0($sp)
addi $sp, $sp, 4			# Tronamos el arreglo
jr $ra