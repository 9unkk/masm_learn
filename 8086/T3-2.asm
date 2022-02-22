;程序名：T3-2.asm
;功能：计算 16X+Y（X 和 Y 均为 16 位无符号数）。
DESG SEGMENT
XXX DW  1234H
YYY DW  5678H
ZZZ DD  ?
DESG    ENDS

CSEG SEGMENT
    ASSUME  cs:CSEG,ds:DESG
start:
    mov AX,DESG
    mov DS,AX
    mov AX,XXX
    xor DX,DX
    add AX,AX   ;计算 x * 16
    adc dx,dx
    add ax,ax   ;x * 4
    adc dx,dx
    add ax,ax   ;x * 8
    adc dx,dx
    add ax,ax   ;x * 16
    adc dx,dx
    add ax,YYY  ;在 x*16的结果上加上y
    adc dx,0
    mov word ptr zzz,ax
    mov word ptr zzz+2,dx
    mov ax,4c00h
    int 21h
CSEG ENDS
     END start

