.data 

bienvenida: .asciiz "Serie de Leibniz\n"
numero: .asciiz "Ingresa un número: "
resultado: .asciiz "\nResultado: "

menosUno: .float -1e0
uno: .float 1e0
dos: .float 2e0
cuatro: .float 4e0

.text
.globl main

main:
li $v0 4 			# Bienvenida del programa
la $a0 bienvenida
syscall

pedimosUnNumero:
la $a0 numero
syscall
li $v0 5
syscall
move $a1 $v0

l.s $f0 menosUno
l.s $f2 menosUno
mtc1 $zero $f4
cvt.s.w $f4 $f4
mov.s $f12 $f4
l.s $f6 dos
l.s $f8 uno


suma:
mul.s $f0 $f0 $f2		# -1 elevado a la n.

mul.s $f10 $f4 $f6		# 2n.
add.s $f10 $f10 $f8		# 2n + 1.

div.s $f10 $f0 $f10		# (-1 elevado a la n) / (2n + 1).
add.s $f12 $f12 $f10		# La suma de todas las iteraciones.

addi $a2 $a2 1			# El contador de integer
add.s $f4 $f4 $f8		# El contador en double
blt $a1 $a2 fin
j suma

fin:
# Multiplicamos el resultado por 4.
l.s $f4 cuatro
mul.s $f12 $f12 $f4

# Imprimimos el resultado.
la $a0 resultado
li $v0 4
syscall
li $v0 2
syscall

finPrograma:			# Fin del programa.
li $v0 10
syscall
