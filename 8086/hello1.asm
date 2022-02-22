;程序名：hello1.asm
;功能：显示一个字符串--调用 DOS 功能函数吗，只能使用代码段。
;=======================
assume cs:code

code segment
string db 'hello welcome to asm!','$'
start:
	
	mov bx,code
	mov ds,bx
	
	mov dx,offset string
	mov si,offset string
	mov ah,9
	int 21h
	
	mov ax,4c00h		
	int 21h
code ends
	end start