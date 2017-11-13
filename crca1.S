   .data
list: .space 2048


    .text
    .global crcInit
    .global crcFast



crcInit:
#rdi - array ptr
#rbx - dividend
#rdx - remainder
#rsi - bit
#rbp - int 256
#rax - 0 register
#rsp - POLYNOMIAL
#rbp - int 128
#r8 - int 1

    mov $list,%rdi
    mov $0, %rbx
    mov $0, %rdx
    mov $8, %rsi
    mov $256, %rbp
    mov $0, %rax
    mov $0xD5, %rsp
    mov $0x80, %rbp
    mov $1, %CL
    call top

top:
    test %rbx, %rbp #is dividend less than 256
    jg end
    #remainder = dividend


    test %rsi, %rax
    jg bitgreater

bitgreater:
    and %rdx, %rbp
    jz If

If:
sal %cl, 4(%rdx)
xor %rdx, %rsp
dec %rsi
inc %rbx
#access array and store remainder using dividend as index
mov %rdx, (%rdi, %rbx, 8)
call top

Else:
sal %cl, 4(%rdx)
dec %rsi
inc %rbx
call top

end:
    ret

crcFast:
