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
	# Entry sequence
	push %ebp
	mov %ebp, %esp
	sub %esp, 48
	#8 bits for unsigned char data +
	#8 bits for char remainder +
	#32 bits for long byte = 48

	# [%ebp + 8] is message, [%ebp + 16] is nBytes
	# [%ebp - 8] is data, [%ebp - 16] is remainder, [%ebp - 48] is byte
	mov $0x0, [%ebp - 16]
	call topFast

topFast:
	test [%ebp - 48], [%ebp +16]
	jg endFast

	mov ([%ebp + 8], [%ebp - 48], 8), %rbx
	xor %rbx, [%ebp - 16]
	mov %rbx, [%ebp - 8]

	mov %list, %rdi
	mov (%rdi, [%ebp - 8], 8), [%ebp -16]

	inc %[%ebp - 48]
	call topFast

endFast:
	# Exit sequence
	mov %esp, %ebp
	pop %ebp
	ret 48
