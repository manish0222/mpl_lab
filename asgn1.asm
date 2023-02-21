section .data
    msg1 db 'accept five 64 bit numbers  ',10,13
    l1 equ $-msg1
    msg2 db 'displayed five 64 bit numbers',10,13
    l2 equ $-msg2
    
section .bss
	array resd 200              ;unitialised variable
	counter resd 1              ; reserved data 
	
section .text
	global _start
        _start:
        mov rax,1                     
        mov rdi,1       
        mov rsi,msg1
        mov rdx,30
        syscall
        
        ;initialise array
        mov byte[counter],05
        mov rbx,00
        
        loop1:
        mov rax,0
        mov rdi,0
        mov rsi,array
        add rsi,rbx
        mov rdx,17
        syscall
        add rbx,17
        dec byte[counter]
        JNZ loop1
        
        ;display message 2
        mov rax,1                     
        mov rdi,1       
        mov rsi,msg2
        mov rdx,30
        syscall
        
        mov byte[counter],05
        mov rbx,00
        
        ;display
        loop2:
        mov rax,1
        mov rdi,1
        mov rsi,array
        add rsi,rbx
        mov rdx,17
        syscall
        add rbx,17
        dec byte[counter]
        JNZ loop2
        
        
        mov rax,60
        mov rdi,0
        syscall

; code at home/desktop/21226
;10,13 represents next line    
;equ replaces the the code by that block
;bss block section size --> that does dynamic input thats not initialised

;input must be 16 numbers   eg 1231234567891479 
;codes to run the file are
;save file as abc.asm
;open the location and open folder in terminal where file is saved\
;type command    nams -f elf64 asgn1.asm
;type ls     
;check asgn1.o file is created or not
;type ld -o file asgn1.o
;type ls
;check in green the file is created or not
;type ./file and run

