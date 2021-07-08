%include "io.mac"

section .text
    global caesar
    extern printf

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the caesar cipher

    ;;initializare contor

    xor eax, eax
;;laber de testare daca contorul nu a depasit length-ul

while:
    cmp eax,ecx
    jl test_caracter
    jmp exit

;;label de incrementare al contorului

aduna:
    add eax,1
    jmp while

;;label de incadrare al caracterului
;;daca depaseste litera 'z'(122)
;;nu cripteaza caracterul pentru ca nu e litera
;;daca este mai mic decat litera 'A'(65)
;;nu cripteaza caracterul
;;daca e mai mic decat 90
;;este litera mare
;;daca e mai mare decat 96
;;este litera mica
;;orice altceva care nu este in conditiile de mai sus nu se cripteaza

test_caracter:
    movzx ebx, BYTE[esi + eax]

    cmp ebx,122

    jg criptare

    cmp ebx,64

    jle criptare

    cmp ebx,90

    jle literaMare

    cmp ebx, 96

    jg literaMica

    jmp criptare

;;daca este litera mare
;;se aduna cu cheia
;;daca depaseste 90
;;se calculeaza restul

literaMare:

    add ebx,edi
    cmp ebx,90
    jg restMare
    jmp criptare

;;se scade 90 si se aduna cu 64 pentru a relua ciclul literelor
;;daca iar depaseste 90, se recalculeaza restul

restMare:

    sub ebx, 90
    add ebx, 64
    cmp ebx, 90
    jg restMare
    jmp criptare

;;daca este litera mica
;;se aduna cheia
;;daca depaseste caracterul 'z'
;;se calculeaza restul

literaMica:

    add ebx,edi
    cmp ebx,122
    jg restMica
    jmp criptare
;;se scade 122 si se aduna 96 pentru a relua ciclul literelor
;;daca inca depaseste caracterul 'Z'
;;se recalculeaza restul

restMica:

    sub ebx, 122
    add ebx, 96
    cmp ebx,122
    jg restMica
    jmp criptare

;;se muta in ciphertext caracterele corespunzatoare

criptare:
    mov BYTE[edx+eax],bl
    jmp aduna

;; DO NOT MODIFY
exit:
    popa
    leave
    ret
    ;; DO NOT MODIFY