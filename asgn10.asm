%macro scall 4 ;common macro for input/output
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro

section .data
num db 00h
msg db "Factorial is : "
msglen equ $-msg
msg1 db "Program to find Factorial of a number",0Ah
db "Enter the number : ",
msg1len equ $-msg1

zerofact db " 00000001 "
zerofactlen equ $-zerofact

section .bss
dispnum resb 16
result resb 4
temp resb 3


section .text
global _start
_start:
scall 1, 1, msg1, msg1len
scall 0, 0, temp, 3 ;accept number from user
call convert    ;convert number from ascii to hex
mov [num], dl

scall 1, 1, msg, msglen

xor rdx, rdx
xor rax, rax

mov al, [num] ;store number in accumulator
cmp al, 01h              ;number is zero or one
jbe endfact

xor rbx, rbx
mov bl, 01h
call factr ;call factorial procedure
call display

call Exit
endfact:
scall 1, 1, zerofact, zerofactlen

Exit: ;exit system call  
    mov rax, 60
    mov rdx, 00
    syscall


factr: ;recursive procedure
    cmp rax, 01h
    je retcon1
    push rax
    dec rax
   
    call factr

    retcon:
        pop rbx
        mul ebx
        jmp endpr

    retcon1: ;if rax=1 return
        pop rbx
        jmp retcon
    endpr:
ret

display: ; procedure to convert hex to ascii
        mov rsi,dispnum+15
        xor rcx,rcx
        mov cl,16

    cont:
        xor rdx,rdx
        xor rbx,rbx
        mov bl,10h
        div ebx
        cmp dl,09h
        jbe skip
        add dl,07h
    skip:
        add dl,30h
        mov [rsi],dl
        dec rsi
        loop cont

        scall 1,1,dispnum,16

ret

convert: ;procedure to convert ascii to hex
        mov rsi,temp
        mov cl,02h
        xor rax,rax
        xor rdx,rdx
    contc:
        rol dl,04h
        mov al,[rsi]
        cmp al,39h
        jbe skipc
        sub al,07h
    skipc:
        sub al,30h
        add dl,al
        inc rsi
        dec cl
        jnz contc

    ret


; code at home/desktop/21226
;10,13 represents next line    
;equ replaces the the code by that block
;bss block section size --> that does dynamic input thats not initialised

;input must be two digit number   eg 03H,05H  etc
;codes to run the file are
;save file as asgn10.asm
;open the location and open folder in terminal where file is saved\
;type command    nams -f elf64 asgn10.asm
;type ls     
;check asgn1.o file is created or not
;type ld -o file asgn10.o
;type ls
;check in green the file is created or not
;type ./file and run
