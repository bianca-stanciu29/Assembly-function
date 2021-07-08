%include "io.mac"

section .text
    global vigenere
    extern printf

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

    ;; TODO: Implement the Vigenere cipher

;;initializare variabile
;;contor pentru plaintext
;;contor pentru litera din plaintext
;;contor pentru key

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx

;;cat timp nu se depaseste lungimea palintext-ului
;;extrag cate un caracter in ebx si il compar in functie de 122
;;daca este mai mic voi testa daca este caracter sau litera
;;daca este mai mare decat 122 va scrie direct in cipher caracterul
;;daca este mai mic decat 63 va scrie direct in cipher caracterul

while:
    cmp eax, [ebp+16]
    jl parcurgere
parcurgere:
    movzx ebx, BYTE[esi+eax]
    cmp ebx, 122
    jle test
    jg vig_criptare1

test:
    cmp ebx,63
    jg test_LiteraMare
    jl vig_criptare1

test_LiteraMare:
    cmp ebx,90
    jle literaMare
    jg literaMica   

;;daca este litera mare, voi aduna litera cu caracterul corespunzator din cheie
;;daca contorul pentru cheie depaseste lungimea initiala se va reinitializa
;;scad 65 deoarece cheia are doar majuscule si testez daca a depasit 90
;;daca depaseste 90 se va calcula restul reluandu-se ciclul de litere

literaMare:
    add bl,BYTE[edi+ecx]
    add ecx, 1
    cmp ecx, [ebp+24]
    jl reinitializare_literaM
    mov ecx, 0
    reinitializare_literaM:
    sub ebx,65
    cmp ebx,90
    jg restMare
    jmp vig_criptare1

restMare:
    sub ebx,90
    add ebx,64
    cmp ebx,90
    jg restMare
    jmp vig_criptare1

;;intre 91-96 este caracter si se scrie direct in ciphertext
;; >96 se aduna litera cu caracterul corespunzator din cheie
;;daca contorul pentru cheie depaseste lungimea initiala se va reinitializa
;;scad 65 deoarece cheia are doar majuscule si testez daca a depasit 122
;;daca depaseste 90 se va calcula restul reluandu-se ciclul de litere

literaMica:
    cmp ebx, 96
    jle vig_criptare1
    add bl, [edi+ecx]
    add ecx,1 
    cmp ecx, [ebp+24]
    jl reinitializare_literam
    mov ecx, 0
    reinitializare_literam:
    sub ebx, 65
    cmp ebx, 122
    jg restMic
    jmp vig_criptare1
restMic:
    sub ebx, 122
    add ebx, 96
    cmp ebx,122
    jg restMic
    jmp vig_criptare1

;;se muta in ciphertext caracterele corespunzatoare
vig_criptare1:
    mov BYTE[edx+eax],bl
    add eax,1
    cmp eax, [ebp+16]
    jl while

    ;; DO NOT MODIFY
exit:
    popa
    leave
    ret
    ;; DO NOT MODIFY