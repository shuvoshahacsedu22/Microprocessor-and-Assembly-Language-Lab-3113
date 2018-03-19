section	.data		
string1: times 1000 db 0
string2: times 1000 db 0			
prompt1: db "Enter the  string :",10,0										;AH,AL(lower 8 bit),AX(16 bit),EAX(32 bit),RAX(64 bit)
prompt2: db "Enter 2nd string ",10,0

prompt3: db "Palindrome",10,0
prompt4: db "Not a palindrome",10,0

length_str: dq 0x00
half_str: dq 0x00

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
	
	lea RDI,[fmt_Sstr]
	lea RSI,[string1]
	mov RAX,0
	call scanf
	
		mov RCX,-1
strlen:

	inc RCX
	mov AL,[string1+RCX*1]
	cmp AL,0
	jne strlen
		
	mov qword [length_str],RCX

	lea RCX,[string1] ; starting of the string
	lea RDX,[string1] ;length of the string
	add RDX,[length_str]
	dec RDX
	
loop1:
	push RCX
	push RDX
	
	mov AL,byte [RCX]
	mov AH,byte [RDX]
	
	cmp AL,AH
	jne notPalindrome
	pop RDX
	pop RCX
	
	dec RDX
	inc RCX
	push RDX
	push RCX
	
	sub RDX,RCX
	mov RAX,RDX
	pop RCX
	pop RDX
	cmp RAX,2
	jg loop1
    jmp palindrome

palindrome:
	lea RDI,[prompt3]
	mov RAX,0
	call printf
	jmp exit
	
notPalindrome:
	
	lea RDI,[prompt4]
	mov RAX,0
	call printf
	pop RDX
	pop RCX
exit:
	mov RAX,60
	pop RBP                                               ;RAX must always be 0 before return
	ret			;return the function
	;	//run command on terminal		
		;nasm -f elf64 file_name.asm
		;gcc file_name.o -o file_name
		;./file_name


