.data
msj: .asciiz "Ingrese a: "
msjB: .asciiz "Ingrese b: "
msjC: .asciiz "Ingrese c: "
msjErr: .asciiz "No hay solucion\n"
msjX1: .asciiz "x1 = "
msjX2: .asciiz "\nx2 = "
msjX3: .asciiz "\nprimera raiz usando la segunda raiz original: "


dos: .double 2.0
cuatro: .double 4.0
cero: .double 0.0


hex1: .asciiz "\nHexadecimal x1: "
hex2: .asciiz "\nHexadecimal x1': "
.text
.globl main

main:


li $v0, 4
la $a0, msj
syscall

li $v0, 7
syscall
mov.d $f2, $f0 # a


li $v0, 4
la $a0, msjB
syscall

li $v0, 7
syscall
mov.d $f4, $f0 # b


li $v0, 4
la $a0, msjC
syscall

li $v0, 7
syscall
mov.d $f6, $f0 # c


mul.d $f8, $f4, $f4


l.d $f10, cuatro
mul.d $f12, $f2, $f6
mul.d $f12, $f12, $f10


sub.d $f14, $f8, $f12

#checamos si la raiz es positiva
l.d $f16, cero
c.lt.d $f14, $f16
bc1t error


sqrt.d $f18, $f14

neg.d $f20, $f4

l.d $f22, dos
mul.d $f22, $f22, $f2

add.d $f24, $f20, $f18
div.d $f24, $f24, $f22

sub.d $f26, $f20, $f18
div.d $f26, $f26, $f22


li $v0, 4
la $a0, msjX1
syscall

mov.d $f12, $f24
li $v0, 3
syscall


li $v0, 4
la $a0, msjX2
syscall

mov.d $f12, $f26
li $v0, 3
syscall

#calculamos usando primera raiz
mul.d $f28, $f2, $f26   
div.d $f30, $f6, $f28   

li $v0, 4
la $a0, msjX3
syscall

mov.d $f12, $f30
li $v0, 3
syscall



# imprimimos x1 en hex
li $v0, 4
la $a0, hex1
syscall

mfc1 $t0, $f24
mfc1 $t1, $f25

li $v0, 34
move $a0, $t1   # mitad 1 pues double es de 64 bits pero los registros temporales son de 32
syscall

li $v0, 34
move $a0, $t0   # mitad 2
syscall


# imprimimos x1' en hex
li $v0, 4
la $a0, hex2
syscall

mfc1 $t2, $f30
mfc1 $t3, $f31

li $v0, 34
move $a0, $t3   # mitad 1
syscall

li $v0, 34
move $a0, $t2   # mitad 2
syscall

j fin

error:
li $v0, 4
la $a0, msjErr
syscall

fin:
li $v0, 10
syscall