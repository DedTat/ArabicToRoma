.MODEL Tiny
.386
.DATA
    ; ��������� ���������
    startinfo db 'Arab to Roma conversion',13,10,'$' 
    
    ; ������� ������
    crlf db 13,10,'$'
    ; ����� ��� �������� ����� � ������
    buf db '      $'
    ; ��������� ���� � ������� ������������
    vals db 1,    4,  5,     9,   10,   40,   50,   90,   100
    roms db 'I ','IV','V ','IX', 'X ', 'XL', 'L ', 'XC', 'C '
    maxn dw 8
    ; ����� ��� ������� �����
    roma db 'xxxxxxxxxxxxxx',13,10,'$'
    ; ������ ������
    maxr dw 14
    ; �������
    i dw 0
.CODE
ORG 100h

; ������ ������
printStr macro
    mov ah,09h        
    int 21h   
endm      

Start:

    mov dx,offset startinfo
    printStr 

; ������� ����
    mov i,1
maincicle:
    mov bx,i             

    ; ������� ������
    mov cx,maxr
    mov di,offset roma
    mov dl,' '
clearcicle:
    mov [di],dl
    inc di
    loop clearcicle
    
; ������� ������
mov cx,0
                          
    ; ������������ ������ �����
    mov dx,maxn           ; 
cicle1:
    ; ������, ���� ����� ������ ����
    cmp bx,0              ; 
    jle cicle1fin         ;

cicle2:
    ; ���� ����� �� ������ dx ������ ��������, ��������� dx
    mov si,offset vals    ; 
    add si,dx             ; 
    cmp [si],bl           ;

    jle nextrom           ;
    dec dl                ;
    jmp cicle2            ;
nextrom:

    ; ��������� ���� ����� �� ����� �� ������ dx
    mov si,offset vals    ; 
    add si,dx
    sub bl,[si]

    ; � ���������� ��� ����� �� ���������� dx (��������� ������)
    ; � ������ ������
    mov si,offset roms    ; 
    add si,dx
    add si,dx
    mov di,offset roma
    add di,cx
    mov al,[si]
    mov [di],al
    inc si
    inc di
    mov al,[si]
    mov [di],al
         
    add cx,2 ; ��������� � ��������� ���� ������ � �������� ������
 
    jmp cicle1
cicle1fin:

    ; ������� ������� ������
    mov dx,offset roma
    printStr 

    ; ��������� ��� ���� ����� �� 20
    inc i
    cmp i,20
    jle maincicle

    retn
 
End Start
