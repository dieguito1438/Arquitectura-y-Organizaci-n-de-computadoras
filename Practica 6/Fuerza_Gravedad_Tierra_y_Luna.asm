.data 

bienvenida: .asciiz "Fuerza gravitacional\n"
resultado: .asciiz "La fuerza de gravedad entre la Luna y la Tierra es de: "
newtons: .asciiz " N"

g : .double 6.674e-11	# Constante Gravitacional.
r : .double 3.844e8	# Distancia entre la Tierra y la Luna 3.844E8 m.
m1: .double 7.348e22 	# Masa de la Luna 7.349 E22
m2: .double 5.972e24 	# Masa de la tierra 5.972 E24 kg.

.text
.globl main

main:
li $v0 4 		# Bienvenida al programa.
la $a0 bienvenida
syscall

calcularFuerza:
l.d $f2 g		# Fuerza de la gravedad.
l.d $f4 r		# Distancia entre la Tierra y la Luna.
l.d $f6 m1		# Masa de la Luna.
l.d $f8 m2		# Masa de la Tierra.

mul.d $f6 $f6 $f8	# m1 * m2
mul.d $f4 $f4 $f4	# r al cuadrado
div.d $f4 $f6 $f4	# (m1 * m2) / (r al cuadrado)
mul.d $f2 $f2 $f4	# G * ((m1 * m2) / (r al cuadrado))
mov.d $f12 $f2

final:
la $a0 resultado		# Imprimimos el resultado.
syscall
li $v0 3
syscall
la $a0 newtons
li $v0 4
syscall

li $v0 10		# Final del programa.
syscall