_start:
call helloStr
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

helloStr:
call helloStr2
.string "Hello, world!\n"
helloStr2:
pop %rcx
mov $14, %rdx
ret

hardcodedFilename:
call hfDataPostCall
.string "./web/index.html"
hfDataPostCall:
pop %rbx
ret

exit:
mov $1, %eax
xor %ebx, %ebx
int $0x80

getEIP:
mov 0(%esp), %eax
ret
