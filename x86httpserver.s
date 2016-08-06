_start:
call helloStr
mov $1, %ebx
mov $4, %eax
int $0x80

jmp exit

helloStr:
# add $8, %eax
jmp helloStrData
helloStr2:
pop %rcx
mov $14, %rdx
ret
helloStrData:
call helloStr2
.string "Hello, world!\n"

exit:
mov $1, %eax
xor %ebx, %ebx
int $0x80

getEIP:
mov 0(%esp), %eax
ret
