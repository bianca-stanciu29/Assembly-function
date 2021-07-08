%include "io.mac"

section .text
    global otp
    extern printf

otp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the One Time Pad cipher

;;initializare contor
    xor eax, eax

    ;;structura de tip while in care parcurg caracter cu caracter
    ;;realizez xor dintre caracterul din plaintext cu cel din key de pe aceleasi pozitii
while:
    movzx ebx, BYTE[esi + eax]
    xor bl, BYTE[edi+eax]
    mov BYTE[edx + eax], bl
    add eax,1
    cmp ecx, eax
    je end
    jmp while
end:  
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

