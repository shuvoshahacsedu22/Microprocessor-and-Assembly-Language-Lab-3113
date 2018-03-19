section	.data		
string1: times 1000 db 0
string2: times 1000 db 0			
prompt1: db "*",0										;AH,AL(lower 8 bit),AX(16 bit),EAX(32 bit),RAX(64 bit)
newline: db 10,0

prompt3: db "Equal",10,0
prompt4: db "Unequal",10,0

count: dq 0x00

fmt_Pstr: db "%s",10,0	;newline is 10
fmt_Pint: db "%d",10,0
fmt_Plong: db "%ld",10,0
fmt_Pfloat:db "%lf",10,0

fmt_Sstr: db "%s",0
fmt_Sint: db "%d",0
fmt_Slong: db "%ld",0
fmt_Sfloat: db "%lf",0


num: times 20 dq 0

section .bss

section .text

global main
																		;main program execution will start from here  
extern printf 															;external function printf called here 
extern scanf
extern gets

main:

	push RBP
	
	lea RDI,[fmt_Slong]
	lea RSI, [num]
	mov RAX,0
	call scanf
	
	
	mov RCX,0
loop1:	
	push RCX
	
	
	loop2:
	
	lea RDI,[prompt1]
	mov RAX,0 
	call printf	
	
exit:
	mov RAX,60
	pop RBP                                               ;RAX must always be 0 before return
	ret			;return the function
	;	//run command on terminal		
		;nasm -f elf64 file_name.asm
		;gcc file_name.o -o file_name
		;./file_name


