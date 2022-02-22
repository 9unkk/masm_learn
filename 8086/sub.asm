;程序名：sub.asm
;功能：两个 64 位数按照高高低低的原则分别存放到 DATA1 和 DATA2 两个缓冲区中
;计算 DATA1-DATA2
;DATA1 = 2000156781234
;DATA2 = 1000212345678

assume cs:code,ds:data

data segment
data1 dw 6AB2h,0B2A2h,01D1h,0
data2 dw 334Eh,0E14Dh,00E8h,0
result dd 0
data ends

code segment
start:
    mov ax,data
    mov ds,ax

    ;优化后程序片段
    xor si,si       ;16位汇编，数据默认从 ds:0 处开始存储
    mov cx,4

    ;源程序片段
    ;mov cx,4
    ;mov bx,6
sub1:
    ;mov si,offset data1
    ;mov di,offset data2
    ;mov ax,[si+bx]
    ;sbb ax,[di+bx]
    ;mov si,offset result
    ;mov word ptr [si+bx],ax


    ;编译器会将标号变成偏移地址，所以定位字符串的时候可使用 [si+标号] == 标号[si]
    mov ax,data1[si]
    ;在运算加法和减法（有符号）时要注意使用 adc 和 sbb 这种带进位和借位的运算指令。
    sbb ax,data2[si]
    mov word ptr result[si],ax
    ;这里使用 add，是因为cx判断在下面，并不影响 ZF 标志寄存器
    add si,2
    dec cx
    jnz sub1

    ;sub bx,2
    ;dec cx
    ;jnz sub1
    ;
    mov ax,4c00h
    int 21h
code ends
    end start