For 64 bit nasm : nasm elf64 -f file_name.asm -o file_name.o && gcc file_name.o -o file_name && ./file_name  
For 32 bit nasm : nasm -f elf file_name.asm -o file_name.o && ld -m elf_i386  file_name.o -o file_name && ./file_name
