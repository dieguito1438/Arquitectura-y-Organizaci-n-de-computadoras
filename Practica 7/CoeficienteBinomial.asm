.data

bienvenida: .asciiz "Coeficiente binomial\n"
numero1: .asciiz "Ingrese el primer número: "
numero2: .asciiz "Ingrese el segundo número: "
resultado: .asciiz "El resultado es: "

.text
.globl main

main:
li $v0 4
la $a0 bienvenida
syscall

pedimosNumeros:			# Pedimos los números al usuario.
la $a0 numero1
syscall
li $v0 5				# Ingresamos el primero número.
syscall
move $a1 $v0
li $v0 4
la $a0 numero2
syscall
li $v0 5				# Ingresamos el segundo número.
syscall
move $a2 $v0
li $a3 0
jal coeficienteBinomial

fin:
la $a0 resultado
li $v0 4
syscall
li $v0 1
move $a0 $a3
syscall

li $v0 10
syscall

# Guardaremos el número en $a0

coeficienteBinomial:
addi $sp, $sp, -12		# Creamos un arreglo de tamaño 12, Cada espacio del arreglo vale 4
sw $ra 0($sp)  			# Guardamos en el arreglo[1] = $ra
sw $a1 4($sp)
sw $a2 8($sp)

beq $a1 $a2 iguales
beqz $a2 a2Cero			# Si $a2 es cero, puede que hayamos llegado a un caso base
beqz $a1 a1Cero			# Si $a1 es cero, puede que hayamos llegado a un caso base

sub $a1 $a1 1			# Ninguno de los posibles casos base, entonces vamos a hacer recursión.
sub $a2 $a2 1
jal coeficienteBinomial		# ($a1 - 1) y ($a2 - 1)

# No es necesario regresar el valor de $a1 ni $a2 a su valor origina, ya que en cuanto termine 
# la subrutina, cargara los valores a los originales al momento de entrar a este marco.
lw $a1 4($sp)
lw $a2 8($sp)
sub $a1 $a1 1			# Segunda recursión.
jal coeficienteBinomial		# ($a1 - 1) y ($a2)

j coeficienteRegreso

a2Cero:
bgtz $a1 a1Mayor
j coeficienteRegreso		# Error en los números, no hacemos nada
a1Mayor:				# $a2 es Cero y #a1 es mayor a cero, sumamos 1
add $a3 $a3 1			
j coeficienteRegreso

a1Cero:				# Sumamos cero (no hacemos nada.).
j coeficienteRegreso

iguales:
add $a3 $a3 1

coeficienteRegreso:
lw $a2, 8($sp)			
lw $a1, 4($sp)
lw $ra, 0($sp)
addi $sp, $sp, 12			# Tronamos el arreglo
jr $ra
