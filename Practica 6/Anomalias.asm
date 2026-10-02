.data 
cero: .float 0.0
uno: .float 1.0
menosuno: .float -1.0
msj: .asciiz "Son iguales \n"
msj2: .asciiz "Son diferentes \n"
cerod: .double 0.0
menoscerod: .double -0.0

msg0: .asciiz "Comparacion NaN y NaN \n"
msg1: .asciiz "Comparacion NaN y NaN double \n"
msg2: .asciiz "Comparacion infinito y -infinito\n"
msg3: .asciiz "Comparacion infinito y -infinito double\n"
msg4: .asciiz "Comparacion 0 y -0\n"
msg5: .asciiz "Comparacion 0 y -0 double \n"

.text
.globl main

main:

l.s $f0, cero
l.s $f1, uno
l.s $f4, menosuno 

#cero y menos cero pero doubles para poderlos comparar asi
l.d $f10, cerod
l.d $f12, menoscerod

div.s $f2, $f1, $f0 # infinito
div.s $f8, $f0, $f0 # NaN
mul.s $f5, $f4, $f0 # -0
mul.s $f6, $f4, $f2 # -infinito

li $v0, 4
la $a0, msg0
syscall
c.eq.s $f8, $f8
bc1t iguales0
bc1f diferentes0

sig1:
li $v0, 4
la $a0, msg1
syscall
c.eq.d $f8, $f8
bc1t iguales1
bc1f diferentes1

sig2:
li $v0, 4
la $a0, msg2
syscall
c.eq.s $f2, $f6
bc1t iguales2
bc1f diferentes2

sig3:
li $v0, 4
la $a0, msg3
syscall
c.eq.d $f2, $f6
bc1t iguales3
bc1f diferentes3

sig4:
li $v0, 4
la $a0, msg4
syscall
c.eq.s $f0, $f5
bc1t iguales4
bc1f diferentes4

sig5:
li $v0, 4
la $a0, msg5
syscall
c.eq.d $f10, $f12
bc1t iguales5
bc1f diferentes5

iguales0:
li $v0, 4
la $a0, msj
syscall
j sig1

diferentes0:
li $v0, 4
la $a0, msj2
syscall
j sig1

iguales1:
li $v0, 4
la $a0, msj
syscall
j sig2

diferentes1:
li $v0, 4
la $a0, msj2
syscall
j sig2

iguales2:
li $v0, 4
la $a0, msj
syscall
j sig3

diferentes2:
li $v0, 4
la $a0, msj2
syscall
j sig3

iguales3:
li $v0, 4
la $a0, msj
syscall
j sig4

diferentes3:
li $v0, 4
la $a0, msj2
syscall
j sig4

iguales4:
li $v0, 4
la $a0, msj
syscall
j sig5

diferentes4:
li $v0, 4
la $a0, msj2
syscall
j sig5

iguales5:
li $v0, 4
la $a0, msj
syscall
j fin

diferentes5:
li $v0, 4
la $a0, msj2
syscall

fin:
li $v0, 10
syscall
