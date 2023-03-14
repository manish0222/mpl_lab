section .data
    msg1 db 'Enter your string ',10,13
    l1 equ $-msg1
    msg2 db 'The Size of String is ',10,13
    l2 equ $-msg2
    
section .bss
	string resd 200              	;unitialised variable
        result resd 200 		;reserved data 
	count resb 1
	
section .text
	global _start
        _start:
        
        mov rax,1                     
        mov rdi,1         		;display 1st number
        mov rsi,msg1
        mov rdx,20
        syscall
        
        ;read string
        mov rax,0                     
        mov rdi,0         		;take string
        mov rsi,string
        mov rdx,200
        syscall
        
     
        dec rax
        mov rbx,rax			;store length
        mov rdi,result
        mov byte[count],16
        
        up:
        rol rbx,04          ;4bit number so rotate by 4
        mov al,bl
 	and al,0fh
 	cmp al,09h
 	Jg add_37           ;jump if greater condition
 	add al,30h
 	JMP loop1
 	
 	add_37:
 	add al,37h
 	
        loop1:
        mov [rdi],al
        
        br1:
        inc rdi
        dec byte[count]
        JNZ up
        
        
        mov rax,1                     
        mov rdi,1         		;display 2nd message
        mov rsi,msg2
        mov rdx,25
        syscall
        
        mov rax,1                     
        mov rdi,1         		;display result
        mov rsi,result
        mov rdx,200
        syscall
        
        ;exit system call
        mov rax,60
        mov rdi,0
        syscall

; code at home/desktop/21226
;10,13 represents next line    
;equ replaces the the code by that block
;bss block section size --> that does dynamic input thats not initialised

;codes to run the file are
;save file as asgn2.asm
;open the location and open folder in terminal where file is saved\
;type command    nams -f elf64 asgn2.asm
;type ls     
;check asgn2.o file is created or not
;type ld -o file asgn1.o
;type ls
;check in green the file is created or not
;type ./file and run

