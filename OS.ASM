_BOOT:
        mov ax,9Ch
        mov ss,ax
        mov sp,4096d
        mov ax,7C0h
        mov ds,ax

;-------------------------------------------------------------------------------------------------------
_STARTUP:
        call _COLORSCR
        call _DRAWBAR
        call _DEFINE
        jmp _MAIN

_MAIN:
        call _CURSOR
        jmp _MAIN

_COLORSCR:
        mov ah,00h
        mov al,03h
        mov bl,1Fh
        int 10h
        ret

_DRAWBAR:
        mov cx,80d
        mov ah,09h
        mov al,20h
        mov BL,0xFF
        int 10h
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
        je _OPTION
        cmp ah,1Ch      ;enter
        je _SELECT
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

_OPTION:
        call _OPTIONSCR
        jmp _MAIN

_SELECT:
        nop
        jmp _MAIN

_OPTIONSCR:
        mov ch,05d
        mov cl,10d
        call _DRAWBAR
        call _DRAWOPTIONSCR
        ret

_DRAWOPTIONSCR:
       call _DRAWOPTIONSCR.Y
       call _DRAWOPTIONSCR.X
       ret

_DRAWOPTIONSCR.Y:
        mov cx,01h
        mov ah,09h
        mov al,20h
        mov bl,0xFF
        int 10h         ;Prints white column
        add ch,01d
        cmp ch,20d
        jne _DRAWOPTIONSCR.Y
        mov ch,dh       ;Fixing the cursor reset  position issue.
        mov cl,dl       ;Fixing the cursor reset  position issue.
        ret

_DRAWOPTIONSCR.X:
        mov cx,01h
        mov ah,09h
        mov al,20h
        mov bl,0xFF
        int 10h
        add cl,01d
        cmp cl,75d
        jne _DRAWOPTIONSCR.X
        ret

_DEFINE:
        mov cx,07h
        mov ah,01h
        int 10h         ;square cursor
        mov ch,0d       ;cursor y
        mov cl,0d       ;cursor x
        ret

;-------------------------------------------------------------------------------------------------------
        times 510 - ($ - $$) db 0
        dw 0xAA55