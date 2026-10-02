.data 

bienvenida: .asciiz "Syscall 38"

.text
.globl main

main: 
la $a0 bienvenida
li $v0 4
syscall

end: 
li $v0 10
syscall