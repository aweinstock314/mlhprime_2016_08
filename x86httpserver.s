_start:

call hardcodedHeader
mov $1, %ebx
mov $4, %eax
int $0x80 # write

call hardcodedFilename
xor %rcx, %rcx
mov $5, %eax
int $0x80 # open
mov %rax, %rdi # store the fd

mov $1, %ebx
mov %rdi, %rcx
xor %rdx, %rdx
mov $0xffff, %esi
mov $187, %eax
int $0x80 # sendfile

mov $6, %eax
mov %rdi, %rbx
int $0x80 # close

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


exit:
mov $1, %eax
xor %ebx, %ebx
int $0x80

getEIP:
mov 0(%esp), %eax
ret
