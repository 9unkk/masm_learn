;程序名：T3-8.asm
;功能：写一个实现把一位十六进制数所对应的 ASCII 码转换为十六进制数的程序。
assume ds:data,cs:code

data segment
ascii db '$'
err db '-','1','$'
data  ends

code segment
start:
    mov ax,data
    mov ds,ax
    ;
    mov dl,ascii
    cmp dl,'0'
    jb error
    cmp dl,'9'
    ja char_A
    sub dl,30h
    jmp output
char_A:
    cmp dl,'A'
    jb error
    cmp dl,'F'
    ja char_aa
    sub dl,37h
    jmp output
char_aa:
    cmp dl,'a'
    jb error
    cmp dl,'f'
    ja error
    sub dl,57h
    jmp output
error:
    xor dh,dh
    mov dh,-1
output:
    cmp dh,-1
    jz char_error
    cmp dl,9
    ja char
    add dl,30h
char:
    add dl,37h
    ;
    mov ah,2
    int 21h
    jmp stop
char_error:
    mov dx,offset err
    mov ah,9
    int 21h
stop:
    mov ax,4c00h
    int 21h
code ends
end start
