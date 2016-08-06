_start:

call helloStr
mov $1, %ebx
mov $4, %eax
int $0x80 # write

jmp exit

helloStr:
call helloStr2
.string "Hello, world!\n"
helloStr2:
pop %rcx
mov $14, %rdx
ret

exit:
mov $1, %eax
xor %ebx, %ebx
int $0x80
