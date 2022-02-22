;程序名：cf.asm
;功能：比较两个无符号数的大小
;CF：CY（carry yes） 、NC（not carry）

;CF 为什么只对无符号数有意义？
;首先需要知道即使两个有符号数相加，也会导致 CF 位变动。但是因为最高位对于有符号数来说是一个符号位，它的变动是没有意义的
;而如果是无符号数，它的变动就意味着指定的寄存器或内存不足以保存数据，因为数据产生了进位或借位。

;CF 位溢出和判断过程：
;1、无符号数1 + 无符号数2 = add
;2、add -（2^n）次方 = C，n 表示最高位进位（溢出位）
;3、C xor 0(如果无符号数使用减法，则 C xor 1)
;4、C=1（有进位或借位），C=0（无进位或借位）
;案例解析：
;0001 + 1110 = 1+14 = 15，15-2^4=0，0 xor 0 = 0，CF=0 （CF=NC=0,无进位或借位）
;0001 - 1110 = 1+(-2) = 15，15-2^4=0，0 xor 1 = 1，CF=1 （CF=CY=1,有进位或借位）
assume cs:code,ds:data

data segment
message1 db "pleas input number1: ","$"
message2 db "pleas input number2: ","$"
result db "result: cf = ","$"
number db 0,0
data ends

code segment
start:
    ;初始化数据段
    mov bx,data
    mov ds,bx
    ;输出message1
    mov dx,offset message1
    mov ah,9h
    int 21h
    ;输入number1
    mov ah,01h
    int 21h
    ;把输入存入number
    mov si,offset number
    ;mov dword ptr ds:[si],ax，下面是该代码的简写
    mov [si],al
    ;输入enter继续执行程序
    mov ah,01h
    int 21h
    cmp al,0Dh
    ;输出message2
    mov dx,offset message2
    mov ah,9h
    int 21h
    ;输入number2
    mov ah,01h
    int 21h
    mov [si+1],al
    ;输入enter继续执行程序
    mov ah,01h
    int 21h
    cmp al,0Dh
    ;输出结果
    mov bl,[si]
    cmp bl,[si+1]
    pushf
    pop ax
    and al,01h
    cmp al,01h
    jz CY
    ;输出结果0
    mov dx,offset result
    mov ah,9h
    int 21h
    mov dl,30h
    mov ah,02h
    int 21h
    jmp stop
CY:
    ;输出结果1
    mov dx,offset result
    mov ah,9h
    int 21h
    mov dl,31h
    mov ah,02h
    int 21h
stop:
    mov ax,4c00h
    int 21h
code ends
    end start

abcdef
11111111