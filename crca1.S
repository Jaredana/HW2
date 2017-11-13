   .data
list: .space 16


    .text
    .global crcInit



crcInit:
#need to work on this obviously, make sure to follow this general syntax
    xor %cx, %cx
    mov %rdi, 0x100

    test %cx, bit #is bit > 0
    jg bitgreater




    test %eax, dividend
    jl crcInit

bitgreater:

    #and %cx, $128 this needs to be fixed
    jz If

If:

Else:

