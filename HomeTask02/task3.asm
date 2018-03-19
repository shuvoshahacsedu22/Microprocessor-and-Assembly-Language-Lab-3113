section	.data		
string1: times 1000 db 0
string2: times 1000 db 0			
prompt1: db "Give %ld more numbers.",10,0										;AH,AL(lower 8 bit),AX(16 bit),EAX(32 bit),RAX(64 bit)
prompt2: db "Number already exists. Give %ld more numbers.",10,0

prompt3: db "The 10 numbers are ",0
prompt4: db ", ",0

newline: db 10,0
count: dq 0
left: dq 0

fmt_Pstr: db "%s",10,0	;newline is 10
fmt_Pint: db "%d",10,0
fmt_Plong: db "%ld",0
fmt_Pfloat:db "%lf",10,0

fmt_Sstr: db "%s",0
fmt_Sint: db "%d",0
fmt_Slong: db "%ld",0
fmt_Sfloat: db "%lf",0

temp: dq 0
num: times 10 dq 0

section .bss

section .text

global main
																		;main program execution will start from here  
extern printf 															;external function printf called here 
extern scanf

main:
	
	push RBP
	mov qword [left],0
	mov qword [count],0
	
	lea RDI,[fmt_Slong]
	lea RSI,[num]
	mov RAX,0
	call scanf
	
	
	
	mov qword [count], 1
	mov qword [left], 9
	
	
loop1:
	
	lea RDI,[fmt_Slong]
	lea RSI,[temp]
	mov RAX,0
	call scanf
	
	
	
		mov RCX,0
	loop2:
		push RCX
		mov RAX,qword [num+RCX*8]
		sub RAX,qword [temp]
		jz matched
		pop RCX
		
		inc RCX
		cmp RCX,qword [count]
		jge insert
		jmp loop2

insert:
	mov RDI,[temp]
	mov RSI,[count]
	mov qword [num+RSI*8],RDI
	
	inc RSI
	mov qword [count],RSI
	mov RDI,10
	sub RDI,RSI
	mov qword [left],RDI
	cmp RDI,0
	je exit
	jmp loop1


matched:
	lea RDI,[prompt2]
	mov RSI,[left]
	mov RAX,0
	call printf
	pop RCX
	jmp loop1
	
exit:
	lea RDI,[prompt3]
	mov RAX,0
	call printf

	mov RCX,0
		
loop3:
	push RCX
	lea RDI,[fmt_Plong]
	mov RSI,qword [num+RCX*8]
	mov RAX,0
	call printf
	
	lea RDI,[prompt4]
	mov RAX,0
	call printf
	
	pop RCX
	inc RCX
	cmp RCX,9
	jl loop3
	
	lea RDI,[fmt_Plong]
	mov RSI,[num+72]
	mov RAX,0
	call printf
	
	lea RDI,[fmt_Pstr]
	lea RSI,[newline+1]
	mov RAX,0
	call printf
	
end:
	mov RAX,60
	pop RBP                                               ;RAX must always be 0 before return
	ret			;return the function
	;	//run command on terminal		
		;nasm -f elf64 file_name.asm
		;gcc file_name.o -o file_name
		;./file_name

