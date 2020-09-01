format mz
org 100h

_STARTUP:
        call _COLORSCR  ;Color screen function
        call _DEFINE    ;Define Registers and Variables
        jmp _MAIN       ;Go to Main system loop

_MAIN:
        call _CURSOR    ;Calls the cursor (Make and control)
        mov ah,0Eh
        int 10h
        jmp _MAIN       ;MAIN Loop

_COLORSCR:
        mov ah,00h
        mov al,03h
        int 10h
        mov ah,02h
        mov ch,00h
        mov cl,00h
        mov dh,ch
        mov dl,cl
        mov bl,0xF0
        int 10h
        ret

_CURSOR:
        mov ah,02h
        mov dh,ch       ;y
        mov dl,cl       ;x
        mov bl,0xF0
        int 10h
        mov ah,00h      ;Wait for key, chars in al reg.
        int 16h
        cmp ah,48h      ;up
        je _CURSORUP
        cmp ah,50h      ;down
        je _CURSORDOWN
        cmp ah,4Bh      ;left
        je _CURSORLEFT
        cmp ah,4Dh      ;right
        je _CURSORRIGHT
        cmp ah,0Eh      ;backspace
        je _BACKSPACE
        cmp ah,1Ch      ;enter
        je _NEWLINE
        add cl,1h
        cmp cl,80d
        je  _NEWLINE
        ret

_CURSORUP:
        cmp ch,0d
        je _CURSOR
        sub ch,1h       ;move up
        jmp _CURSOR

_CURSORDOWN:
        cmp ch,24d
        je _CURSOR      ;move down
        add ch,1h
        jmp _CURSOR

_CURSORLEFT:
        cmp cl,0h
        je _CURSOR      ;move left
        sub cl,1h
        jmp _CURSOR

_CURSORRIGHT:
        cmp cl,79d
        je _CURSOR
        add cl,1h       ;move right
        jmp _CURSOR

_BACKSPACE:
        sub cl,1h
        mov ah,09h
        mov al,20h
        mov bl,0xF0
        int 10h
        jmp _MAIN

_NEWLINE:
        mov cl,0
        add ch,1
        jmp _MAIN

_DEFINE:
        mov ch,0d       ;cursor y
        mov cl,0d       ;cursor x
        ret