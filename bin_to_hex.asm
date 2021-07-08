%include "io.mac"

section .text
    global bin_to_hex
    extern printf

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    mov     ecx, [ebp + 16]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement bin to hex

;;contor pentru bin_sequence(parcurgere de la dreapta la stanga)
;;contor pentru pozitia bitilor:0,1,2 sau 4
;;initializare hexa_value
;;contor pentru stiva

   sub ecx,1
   xor eax, eax
   xor edx, edx
   xor edi,edi

;;daca nu s-a terminat sirul, testez pe ce pozitie se afla contorul pentru bit
;;daca este pe pozitia 0 si bitul de acolo este 1 se va aduna 1 la rezultat
;;daca este pe pozitia 1 si bitul de acolo este 1 se va aduna 2 la rezultat
;;daca este pe pozitia 2 si bitul de acolo este 1 se aduna cu 4 la rezultat
;;daca este pe pozitia 4 si bitul de acolo este 1 se aduna cu 8 la rezultat
;;daca rezultatul < 10 se va pune pe stiva valoarea obtinuta
;;daca rezultatul este >10 atunci se va transforma in litera: scad 10 si adun 65
;;se va pune apoi pe stiva valoarea obtinuta
;;se reinitializeaza hexa_value si se va trece la urmatorul grup de biti
;;daca hexa_value(edx) ramane 0 atunci lungimea sirului se imparte la 4
;;in stiva nu se va mai pune valoarea 0
;;daca exista un rest la impartire, ultima valoare de pe stiva va fi ultima suma calculata
;;in functie de cate valori am pus pe stiva, la final voi extrage pe rand si voi pune in rezultatul final

while:
    cmp ecx, 0
    jge test_caz
    jl rezultat_rest
test_caz:
    cmp eax, 0
    je test_bit_01

    cmp eax, 1
    je test_bit_02

    cmp eax,2
    je test_bit_03

    cmp eax,3
    je test_bit_04

test_bit_01:
    movzx ebx, BYTE[esi+ecx]
    sub ecx,1
    add eax,1
    cmp ebx, 49
    je bit_1    
    jmp while

bit_1:
    add edx,1
    jmp while

test_bit_02:
    movzx ebx, BYTE[esi+ecx] 
    sub ecx,1
    add eax,1
    cmp ebx,49
    je bit_2
    jmp while

bit_2:
    add edx,2
    jmp while

test_bit_03:
    movzx ebx, BYTE[esi+ecx] 
    sub ecx,1
    add eax,1
    cmp ebx,49
    je bit_3
    jmp while

bit_3:
    add edx,4
    jmp while

test_bit_04:
    movzx ebx, BYTE[esi+ecx]
    sub ecx, 1
    mov eax,0  
    cmp ebx,49
    je bit_4 
    add edx,48
    push edx
    add edi,1
    xor edx,edx
    jmp while

bit_4:
    add edx,8
    cmp edx,10
    jge transformare_litera
    add edx,48
    push edx
    add edi,1
    xor edx,edx
    jmp while

transformare_litera:
    sub edx,10
    add edx, 65
    push edx
    add edi,1
    xor edx,edx
    jmp while

rezultat_rest: 
    xor ebx, ebx
    cmp edx, 0
    je while2
    add edx,48
    push edx
    add edi,1

while2:
    cmp ebx, edi
    jl afiseaza
    jge exit

afiseaza:
    pop edx
    mov eax, [ebp+8]
    mov BYTE[eax + ebx], dl
    add ebx,1
    jmp while2
    ;; DO NOT MODIFY
exit:
    mov eax, [ebp+8]
    mov BYTE[eax+ebx], 10

    popa
    leave
    ret
    ;; DO NOT MODIFY