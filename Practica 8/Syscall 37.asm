.data

bienvenida: .asciiz "Syscall 37\n"

.text
.globl main:

main: 
la $a0 bienvenida
li $v0 4
syscall

end: 
li $v0 10
syscall