org 100h

_main:
        mov si,msg
        call _printstr
        call _pause
        int 20h         ;End program

_printstr:              ;Print function
        lodsb
        cmp al,24h
        je _endstr
        mov ah,0Eh
        int 10h
        jmp _printstr

_endstr:
        ret

_pause:
        mov ah,00h
        int 16h         ;Pause until key pressed

msg db 'Paused!$'