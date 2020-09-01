org 100h

_main:
mov si,msg
call _printstr
call _pause
int 20h                 ;Close program

_pause:                 ;Pause function
        mov ah,08h
        int 21h
        ret             ;Return command

_printstr:              ;function to display string
        lodsb           ;lowest byte
        cmp al,24h      ;compare with "$" (End of string)
        je _printend    ;Print end function
        mov ah,0Eh      ;displays current character
        int 10h
        jmp _printstr

_printend:     ;Return function to main
        ret

msg db 'Print function$'