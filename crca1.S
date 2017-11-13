    section .data
remainder:   dw  0
dividend: dq 0
bit: dw 8

    section .text
    global crcInit

;;This is a comment

crcInit:
    mov eax, 256 ;;set eax to 255 (Counter max 1)
    xor cx, cx

    test cx, bit ;;is bit > 0
    jg bitgreater

    ;;else store result into table and return
    sw ((address or CRCTABLE),(dividend),4)

    test eax, dividend ;;compare dividend to 255 to see if its less
    jl crcInit

bitgreater:
    ;;we want to try remainder division if bit is > 0
    and cx, 128
    jz If
    goto Else
If:

Else:

