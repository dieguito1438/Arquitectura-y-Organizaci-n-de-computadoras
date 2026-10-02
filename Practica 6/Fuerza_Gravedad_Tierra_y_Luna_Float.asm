.data 

bienvenida: .asciiz "Fuerza gravitacional\n"
resultado: .asciiz "La fuerza de gravedad entre la Luna y la Tierra es de: "
newtons: .asciiz " N"

g : .float 6.674e-11	# Constante Gravitacional.
r : .float 3.844e8	# Distancia entre la Tierra y la Luna 3.844E8 m.
m1: .float 7.348e22 	# Masa de la Luna 7.349 E22
m2: .float 5.972e24 	# Masa de la tierra 5.972 E24 kg.

.text
.globl main

main:
li $v0 4 		# Bienvenida al programa.
la $a0 bienvenida
syscall

calcularFuerza:
l.s $f2 g		# Fuerza de la gravedad.
l.s $f4 r		# Distancia entre la Tierra y la Luna.
l.s $f6 m1		# Masa de la Luna.
l.s $f8 m2		# Masa de la Tierra.

mul.s $f6 $f6 $f8	# m1 * m2.
mul.s $f4 $f4 $f4	# r al cuadrado.
div.s $f4 $f6 $f4	# (m1 * m2) / (r al cuadrado).
mul.s $f2 $f2 $f4	# G * ((m1 * m2) / (r al cuadrado)).
mov.s $f12 $f2

final:
la $a0 resultado
syscall
li $v0 2
syscall
la $a0 newtons
li $v0 4
syscall

li $v0 10		# Final del programa.
syscall