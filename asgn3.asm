%macro rw 4
mov rax,%1                   			;syscall
mov rdi,%2					;standard input or output
mov rsi,%3					;address
mov rdx,%4					;rdx 
syscall
%endmacro
					;ASSIGNMENT 3-Largest Number in Static array
section .data
	array db 6h,56h,54h,22h,42h
	msg1 db "Elements of array: ",10,13
	l1 equ $-msg1
	msg2 db "maximum is ",
	l2 equ $-msg2
	msg3 db "minumum is ",10
	l3 equ $-msg3

section .bss	
	counter resb 1 	             
	result resb 4				;unitialised variable
	
section .text
	global _start
        _start:
        
 	rw 1,1,msg2,l2	  		        ;using macro
 	        
        ;initialise array
        mov byte[counter],05
        mov rsi,array
        mov al,0
        
repeat: cmp al,[rsi]
	jg skip
	mov al,[rsi]
	
skip:	inc rsi
	dec byte[counter]
	Jnz repeat
	
	call disp
	
	mov rax,60
	mov rdi,1
	syscall
        
        
disp:	
    mov bl,al		
    mov rdi,result
    mov cx,2
    
up1:	
    rol bl,04
    mov al,bl
    and al,0fh
    cmp al,09h
    jg add_37
    add al,30h
    jmp skip1

add_37: add al,37_h

skip1: mov [rdi],al
	inc rdi
	dec cx
	jnz up1
	
	rw 1,1,result,4
	ret        

; code at home/desktop/21226
;10,13 represents next line    
;equ replaces the the code by that block
;bss block section size --> that does dynamic input thats not initialised

;codes to run the file are
;save file as asgn3.asm
;open the location and open folder in terminal where file is saved
;type command    nasm -f elf64 asgn3.asm
;type ls     
;check asgn3.o file is created or not
;type ld -o file asgn1.o
;type ls
;check in green the file is created or not
;type ./file and run
