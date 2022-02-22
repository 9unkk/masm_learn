;程序名：T3-5.asm
;功能：求1~10的对数值
assume cs:code,ds:data

data segment
VLAUE DB 4
ANSWER DW ?
TAB DW 0,3010,4771,6021,6990,7782,8451,9031,9542,10000  ;对数表
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    ;
    mov al,VLAUE
    xor ah,ah
    dec ax
    add ax,ax
    mov bx,ax
    mov ax,TAB[bx]
    mov ANSWER,ax
    mov ax,4c00h
    int 21h
code ends
    end start


