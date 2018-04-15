section	.data					

prompt1: db "REMOVING DUPLICATES",10,"    ===================",10,"Enter the  string: ",0								;AH,AL(lower 8 bit),AX(16 bit),EAX(32 bit),RAX(64 bit)
prompt2: db "Required string is : ",0

strouput: times 1000 db 0
strinput: times 1000 db 0

fmt_Pch: db "%c",10,0
fmt_Pstr: db "%s",10,0													;newline is 10
fmt_Pint: db "%d",10,0
fmt_Plong: db "%lld",10,0
fmt_Pfloat:db "%lf",10,0


fmt_Sch: db "%c",0
fmt_Sstr: db "%s",0
fmt_Sint: db "%d",0
fmt_Slong: db "%lld",0
fmt_Sfloat: db "%lf",0

len: dq 0

section .bss

section .text


global main
																		;main program execution will start from here  prompt2: db "Enter the %ld numbers in ascending order: ",10,0
extern printf 															;external function printf called here 
extern scanf
extern gets
extern puts
extern putchar
extern strlen


main:
	
	push RBP
	mov RBP,RSP

	lea RDI,[prompt1]
	mov RAX,0
	call puts
		
	lea RDI,[strinput]    												;parameter passing order -->>  rdi,rax,rdx,rsi,r8....r9
	mov RAX,0 
	call gets

	lea RDI,[strinput]
	mov RAX,0
	call strlen
	mov [len],RAX
	
	
	lea RDI,[prompt2]
	mov RAX,0
	call puts
	
	
	xor RAX,RAX
	push RAX
	call RECUR
	pop RAX
	
exit:
	mov RDI,10
	call putchar
											;parameter passing order -->>  rdi,rax,rdx,rsi,r8....
	mov RAX,60
	pop RBP            ;RAX must always be 0 before return
	ret			;return the function
	            ;	//run command on terminal		
		;nasm -f elf64 file_name.asm
		;gcc file_name.o -o hljj									
		;./file_name														
										;							
										;stack pos decreases ...  0 8 16 24 32 40 48 56 64 .......

RECUR:
	push RBP
	mov RBP,RSP
	
	mov RAX,[RBP+16]  ;index I am working on

	cmp RAX , [len]
	jge BASE_CASE
	
	xor RBX,RBX
	mov BL,byte [strinput+RAX*1] ;character at the index 
	
	  ;actual value 
	  ;reached the last 
	  ;BL has value between 0 - 25 
	 
	 
	 
	xor RCX,RCX
	mov CL,byte [strouput+RBX*1] ; value at position of the character

	cmp CL,0 ;if value is zero means seen first time
	
	jne CALLAGAIN ;found in previous call
	
			;seen for the first time
	 mov byte [strouput+RBX*1],BL ; change the value at BL index 
	 
	 
	 mov RDI,RBX
	 call putchar
	 
	 
	 mov RAX,[RBP+16]
	 inc RAX
	 push RAX
	 call RECUR
	 
	 leave
	 ret
	
	
CALLAGAIN:
		inc RAX
		push RAX
		call RECUR
		leave
		ret
		
		
BASE_CASE:
	leave
	ret
