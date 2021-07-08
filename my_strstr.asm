%include "io.mac"

section .text
    global my_strstr
    extern printf

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY

    ;; TO DO: Implement my_strstr

;;initializare variabile
;;contor pentru haystack_len
;;contor pentru needle_len

    xor eax,eax
    xor ecx, ecx
    xor edx,edx
   
;;cat timp nu s-a ajuns la finalul sirului haystack, respectiv needle
;;compar primul caracter din needle cu fiecare din haystack
;;cand s-a gasit o egalitate, creste contorul si pentru needle, si pentru haystack
;;daca egalitatea se mentine, vor creste contoarele din nou pana va ajunge la final contorul pentru needle
;;se va scadea in acest caz valoarea la care a ajuns contorul pentru haystack cu cel pentru needle
;;daca egaliatatea nu se mentine, contorul pentru needle se reinitializeaza
;;se reia compararea cu primul caracter din needle 
;;daca contorul pentru needle nu ajunge la final in rezultat se va pune lungimea haystack-ului + 1

while:
    cmp eax,[ebp+20]
    jl while2
    jg gasit
while2:
    cmp ecx,[ebp+24]
    jl parcurgere
    jge rezultat

parcurgere:
    movzx edx, BYTE[esi+eax]
    cmp BYTE[ebx+ecx], dl
    je incrementare
    jne reinitializare
    add eax,1
    jmp while

reinitializare:
    mov ecx, 0
    add eax, 1
    jmp while
    
incrementare:
    add eax,1
    add ecx,1
    jmp while

rezultat:
   
    sub eax,ecx
    mov edi, eax
    mov eax, [ebp+8]
    mov [eax], edi
    jmp exit

gasit:
    cmp ecx,0
    je rezultat2

rezultat2:
    mov edi, eax
    mov eax, [ebp+8]
    mov [eax], edi
    ;; DO NOT MODIFY
exit:
    popa
    leave
    ret
    ;; DO NOT MODIFY
