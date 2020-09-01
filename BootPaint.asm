_BOOT:
        mov ax,9Ch
        mov ss,ax
        mov sp,4096d
        mov ax,7C0h
        mov ds,ax
;-------------------------------------------------------------
_STARTUP:
        call _COLORSCR  ;Color screen function
        call _DEFINE    ;Define Registers and Variables
        jmp _MAIN       ;Go to Main system loop

_MAIN:
        call _CURSOR    ;Calls the cursor (Make and control)
        jmp _MAIN       ;MAIN Loop

_COLORSCR:
        mov ah,00h
        int 10h
        mov cx,2000d    ;area
        mov ah,09h
        mov al,20h
        mov bl,0Fh
        int 10h         ;fill console
        ret

_CURSOR:
        mov ah,02h
        mov dh,ch       ;y
        mov dl,cl       ;x
        mov bl,0xFF
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
        je _ERASE
        cmp ah,39h      ;space
        je _DRAW
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

_ERASE:
        mov cx,1h
        mov ah,09h
        mov al,20h
        mov bl,0Fh
        int 10h         ;Prints black column
        mov ch,dh       ;Fixing the cursor reset  position issue.
        mov cl,dl       ;Fixing the cursor reset  position issue.
        jmp _CURSOR

_DRAW:
        mov cx,1h
        mov ah,09h
        mov al,20h
        mov bl,0xFF
        int 10h         ;Prints white column
        mov ch,dh       ;Fixing the cursor reset  position issue.
        mov cl,dl       ;Fixing the cursor reset  position issue.
        jmp _CURSOR

_DEFINE:
        mov cx,07h
        mov ah,01h
        int 10h         ;square cursor
        mov ch,0d       ;cursor y
        mov cl,0d       ;cursor x
        ret
;------------------------------------------------------------
times 510-($-$$) db 0
dw 0xAA55               ;signature
