section .data
    msg1 db 10,'Number is:  ',10
    msg1_len equ $-msg1
   
    msg2 db 10,10, 'Factorial is ',10
    msg2_len equ $-msg2
   
    nwline db 10
   
section .bss
fact resb 8
num resb 2

%macro print 2

    mov rax,1
    mov rdi,1
    mov rsi,%1
    mov rdx,%2
    syscall
   
%endmacro

%macro exit 0
mov rax,60
mov rdi,0
syscall
%endmacro

section .text
global _start
_start:

pop rbx
pop rbx
pop rbx

mov [num],rbx

print msg1,msg1_len

print [num],2

mov rsi,[num]
mov rcx,02

xor rbx,rbx
call AtoH
mov rax,rbx
call factp

mov rcx,08
mov rdi,fact
xor bx,bx
mov ebx,eax
call HtoA

print nwline,1

print msg2,msg2_len
print fact,4

print nwline,1

exit

factp:
dec rbx
cmp rbx,01
jbe b1
mul rbx
call factp
b1:ret

AtoH:
up1: rol bx,04
mov al,[rsi]
cmp al,39H
jbe A2
sub al,07H
A2: sub al,30H
add bl,al
inc rsi
loop up1
ret

HtoA:
up2: rol bx,4
mov ax,bx
and ax,0fH
cmp ax,09H
jbe s1
add ax,07H
s1: add ax,30H
mov [rdi],ax
inc rdi
loop up2
ret

; code at home/desktop/21226
;10,13 represents next line    
;equ replaces the the code by that block
;bss block section size --> that does dynamic input thats not initialised

;codes to run the file are
;save file as abc.asm
;open the location and open folder in terminal where file is saved\
;type command    nams -f elf64 asgn7.asm
;type ls     
;check asgn1.o file is created or not
;type ld -o file asgn7.o
;type ls
;check in green the file is created or not
;type ./file and run
