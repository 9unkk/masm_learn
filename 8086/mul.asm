;程序名：mul.asm
;功能：乘法运算

;imul（有符号数乘法）、mul（无符号数乘法）
;两条指令都是对AL、AX 执行无符号数乘法操作
;=================================
assume cs:code,ds:data

data segment
val1 db 2
val2 db 9
val3 db 20
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    ;如果乘数是 8 位，被乘数在 al 中，积在 ax 中。不论结果是否超过 al ，ah都会被覆盖。如果16位积扩展到 ah ，CF 置为 1
    mov al,val1
    mul val1
    mov bl,val2
    mul bl
    ;如果乘数是 16 位的，被乘数在 ax 中，积在 DX:AX 中。如果积扩展到 DX ，CF 置为 1
    mov ah,1
    mov al,val3
    mov bx,10
    mul bx
    ;
    mov ax,word ptr val1
    mov cx,-1
    mul cx
    ;如果乘积扩展到 DX 中，则 OF 置为 1，如果 DX=FFFF 说明这是符号位，CF、OF 为 0
    mov bx,word ptr val2
    mov ax,-1
    imul bx
    ;
    mov ax,4c00h
    int 21h
code ends
end start