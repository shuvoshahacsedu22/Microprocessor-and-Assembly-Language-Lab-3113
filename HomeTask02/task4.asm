section	.data		
string1: times 1000 db 0
string2: times 1000 db 0			
prompt1: db "Enter 1st string ",10,0										;AH,AL(lower 8 bit),AX(16 bit),EAX(32 bit),RAX(64 bit)
prompt2: db "Enter 2nd string ",10,0

prompt3: db "Equal",10,0
prompt4: db "Unequal",10,0

sum: dq 0x00

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
	lea RDI,[prompt1]
	mov RAX,0 
	call printf	
	
	lea RDI,[string1]
	mov RAX,0
	call gets
	
	lea RDI,[prompt2]
	mov RAX,0
	call printf
	
	lea RDI,[string2]
	mov RAX,0
	call gets

	mov RCX,0
loop:
	push RCX
	mov AL,[string1+RCX]
	mov AH,[string2+RCX]
	cmp AL,AH
	je okay
	jmp unequal

okay:
	pop RCX
	INC RCX
	mov AL,[string1+RCX]
	cmp AL,0x0
	je equal
	jmp loop

equal:
	
	lea RDI,[prompt3]
	mov RAX,0 
	call printf	
	jmp exit
	
unequal:
	
	lea RDI,[prompt4]
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


