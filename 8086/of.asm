;程序名：of.asm
;功能：比较两个有符号数的大小
;OF：OV（Overflow）、NV（Not Overflow）

;OF 为什么只对有符号数有意义？
;因为两个指定大小的寄存器内的有符号数（要求在不超过寄存器的取值范围），这 2 个数只有同号（都为正或负）相加才会溢出，也就是超过有符号数的范围，出现了溢出
;例如：寄存器运算，2个8位的有符号数（此时CF=0），相加后出现溢出，由于第7位的进位，此时OF变成了1。两个正数相加变成了负数，这显然不合理，所以出现溢出。
;OF的作用是由于符号位发生了改变，所以说OF只对有符号数有意义。

;OF溢出和判断过程
;溢出位 xor 次高位
;示例：一共4位数，最高是符号位。
;0100 + 0101 = 1001，OF=1 xor 1 = NV = 0（无溢出）
;1000 + 1100 = 0100，OF=1 xor 0 = OV = 1（有溢出）
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
    jz OV
    ;输出结果0
    mov dx,offset result
    mov ah,9h
    int 21h
    mov dl,30h
    mov ah,02h
    int 21h
    jmp stop
OV:
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