INCLUDE Irvine32.inc

.data
    prompt BYTE "Enter a number: ", 0
    resultMsg BYTE "Factorial: ", 0

.code
main PROC
    ; Display prompt
    mov edx, OFFSET prompt
    call WriteString
    
    ; Read user input
    call ReadInt
    mov ebx, eax ; Save the number in EBX

    ; Call the factorial procedure
    INVOKE factorial, ebx
    
    ; Display the result
    mov edx, OFFSET resultMsg
    call WriteString
    call WriteInt

    ; Exit program
    call Crlf
    exit
main ENDP

; Procedure to calculate factorial
factorial PROC number:DWORD
    mov eax, 1 ; Initialize result to 1
    mov ecx, 1 ; Initialize loop counter to 1

    ; Loop to calculate factorial
factorial_loop:
    cmp ecx, number ; Check if loop counter exceeds the input number
    jg factorial_end ; If yes, exit loop
    imul eax, ecx ; Multiply result by loop counter
    inc ecx ; Increment loop counter
    jmp factorial_loop ; Repeat loop

factorial_end:
    ret
factorial ENDP

END main
