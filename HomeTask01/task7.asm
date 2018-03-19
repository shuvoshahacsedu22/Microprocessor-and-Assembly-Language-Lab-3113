segment	.data					

string: times 1000 db 0
out1: db "Given input: %s",10,0
out2: db "Vowels: %ld Consonants: %ld",10,0
fmt_Pstr: db "%s",0	;newline is 10
fmt_Pint: db "%d",10,0
fmt_Plong: db "%ld",10,0
fmt_Pfloat:db "%lf",10,0

fmt_Sstr: db "%s",0
fmt_Sint: db "%d",0
fmt_Slong: db "%ld",0
fmt_Sfloat: db "%lf",0

prompt: db "Enter any strig below: ",10,0

Vowel_count: dq 0
Cons_count:   dq 0

segment .bss

segment .text

global main
											;main program execution will start from here  
extern printf 								;external function printf called here 
extern scanf
extern gets

main:
	push RBP
	
	lea RDI,[fmt_Pstr]
	lea RSI,[prompt]
	mov RAX,0 
	call printf
	
	lea RDI,[string]
	mov RAX,0
	call gets
	
	mov RCX,0
	
loop1:

	push RCX
	
	mov AL,[string+RCX]
	
	cmp AL, 'a'
	je vowel
	cmp AL ,'e'
    je vowel
    cmp AL, 'i'
    je vowel
    cmp AL ,'o'
    je vowel
    cmp AL ,'u'
    je vowel
    
	INC qword [Cons_count]   ;increase the number of consonats
    jmp consonant
    
vowel:
		INC qword [Vowel_count]
consonant:
    pop RCX
    INC RCX
    mov RAX,[string+RCX]
    cmp AL,' '
    je decCons
    cmp AL,'a'
    jl end
    cmp AL,'z'
    jg end
	jmp loop1
decCons:
	DEC qword [Cons_count]
	jmp loop1
	
end:
	lea RDI,[out1]
	lea RSI,[string]
	mov RAX,0
	call printf
	
	lea RDI,[out2]
	mov RSI,[Vowel_count]
	mov RDX,[Cons_count]
	mov RAX,0
	call printf         
	         
exit:
	mov RAX,60
	pop RBP                                               ;RAX must always be 0 before return
	ret			;return the function
	;	//run command on terminal		
		;nasm -f elf64 file_name.asm
		;gcc file_name.o -o hljj
		;./hljj



