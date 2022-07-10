.MODEL Tiny
.386
.DATA
    ; Текстовые константы
    startinfo db 'Arab to Roma conversion',13,10,'$' 
    
    ; Перевод строки
    crlf db 13,10,'$'
    ; Буфер для перевода числа в строку
    buf db '      $'
    ; Константы цифр и римских соответствий
    vals db 1,    4,  5,     9,   10,   40,   50,   90,   100
    roms db 'I ','IV','V ','IX', 'X ', 'XL', 'L ', 'XC', 'C '
    maxn dw 8
    ; Буфер для римских чисел
    roma db 'xxxxxxxxxxxxxx',13,10,'$'
    ; Размер буфера
    maxr dw 14
    ; Счетчик
    i dw 0
.CODE
ORG 100h

; Печать строки
printStr macro
    mov ah,09h        
    int 21h   
endm      

Start:

    mov dx,offset startinfo
    printStr 

; Главный цикл
    mov i,1
maincicle:
    mov bx,i             

    ; Очистка строки
    mov cx,maxr
    mov di,offset roma
    mov dl,' '
clearcicle:
    mov [di],dl
    inc di
    loop clearcicle
    
; Позиция строки
mov cx,0
                          
    ; Максимальный разряд числа
    mov dx,maxn           ; 
cicle1:
    ; Крутим, пока число больше нуля
    cmp bx,0              ; 
    jle cicle1fin         ;

cicle2:
    ; Пока число по адресу dx больше текущего, уменьшаем dx
    mov si,offset vals    ; 
    add si,dx             ; 
    cmp [si],bl           ;

    jle nextrom           ;
    dec dl                ;
    jmp cicle2            ;
nextrom:

    ; Уменьшаем само число на число по адресу dx
    mov si,offset vals    ; 
    add si,dx
    sub bl,[si]

    ; И прибавляем два байта по удвоенному dx (фиктивный массив)
    ; к буферу вывода
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
         
    add cx,2 ; Переходим к следующим двум байтам в выходной строке
 
    jmp cicle1
cicle1fin:

    ; Выводим готовую строку
    mov dx,offset roma
    printStr 

    ; Повторяем для всех чисел до 20
    inc i
    cmp i,20
    jle maincicle

    retn
 
End Start
