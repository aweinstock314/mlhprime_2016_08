_start:

mov $1, %r13
call serveToR13

call makeBoundSocketToR12

serverLoop:
mov %r12, %rdi
xor %rsi, %rsi
xor %rdx, %rdx
mov $43, %rax
syscall # accept(fd, 0, 0)
mov %rax, %r13
call serveToR13
mov $3, %rax
mov %r13, %rdi
syscall # close(newfd)
jmp serverLoop

jmp exit

hardcodedFilename:
call hfDataPostCall
.string "./web/index.html"
hfDataPostCall:
pop %rbx
ret

hardcodedHeader:
call headerPostCall
.string "HTTP/1.0 200 OK\nContent-type: text/html\n\n"
headerPostCall:
pop %rcx
mov $41, %rdx
ret

makeBoundSocketToR12:
# uses %r12 to store the bound socket, since it's a free register (not used by syscalls)
mov $41, %rax
mov $0x0,%edx
mov $0x1,%esi
mov $0x2,%edi
syscall # socket(AF_INET, SOCK_STREAM, 0)
mov %rax, %r12

call hardcodedAddr
mov %r12, %rdi
mov $49, %rax
syscall # bind(fd, HARDCODED_ADDR, sizeof(HARDCODED_ADDR))

mov $5, %rsi
mov $50, %rax
syscall # listen(fd, 5)
ret

hardcodedAddr:
call addrPostCall
# idk why it wants 16 bytes, but bind returns EINVAL for 8 bytes, so pad with zeros
.string "\x02\x00\x23\x29\x00\x00\x00\x00\0\0\0\0\0\0\0\0"
addrPostCall:
pop %rsi
mov $16, %rdx
ret

serveToR13:
call hardcodedHeader
mov %r13, %rbx
mov $4, %eax
int $0x80 # write

call hardcodedFilename
xor %rcx, %rcx
mov $5, %eax
int $0x80 # open
mov %rax, %rdi # store the fd

mov %r13, %rbx
mov %rdi, %rcx
xor %rdx, %rdx
mov $0xffff, %esi
mov $187, %eax
int $0x80 # sendfile

mov $6, %eax
mov %rdi, %rbx
int $0x80 # close rdi
ret


exit:
mov $1, %eax
xor %ebx, %ebx
int $0x80

getEIP:
mov 0(%esp), %eax
ret
