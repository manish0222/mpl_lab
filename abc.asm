section .data
    text db'Hello World',10,13
section .text
global _start
       _start:
       mov rax,1
       mov rdi,1
       mov rsi,text
       mov rdx,14
       syscall
       
       mov rax,60
       mov rdi,0
       syscall
       
       
;codes to run the file are
;save file as abc.asm
;open the location and open folder in terminal where file is saved\
;type command    nams -f elf64 abc.asm
;type ls     
;check abc.o file is created or not
;type ld -o file abc.o
;type ls
;check in green the file is created or not
;type ./file and run

