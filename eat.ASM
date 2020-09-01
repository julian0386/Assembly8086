org 100h

_STARTUP:
        call _BACKGROUND
        jmp _MAIN

_MAIN:
        call _KEYCHECK
        call _PLAYER
        call _FOOD
        call _LIFE
        jmp _MAIN       ;Main loop

_BACKGROUND:
        mov ah,13h
        int 10h
        mov ah,02h
        mov bl,00h
        mov dh,00h
        mov dl,00h
        int 10h
        mov cx,2000d
        mov ah,09h
        mov bl,00h
        mov al,20h
        int 10h
        mov bl,0Fh
        int 10h
        ret

_KEYCHECK:
        mov ah,01h
        int 16h
        jz _NOKEY
        mov ah,00h
        int 16h
        cmp al,1Bh      ;ESC
        je _QUIT
        cmp ah,48h      ;UP
        je _PLAYER.UP
        cmp ah,50h      ;DOWN
        je _PLAYER.DOWN
        cmp ah,4Bh      ;LEFT
        je _PLAYER.LEFT
        cmp ah,4Dh      ;RIGHT
        je _PLAYER.RIGHT
        ret

_NOKEY:
        ret

_PLAYER:
        mov ah,02h
        mov dh,[Player.Y]
        mov dl,[Player.X]
        mov bl,1Fh
        int 10h
        mov cx,01h
        mov ah,09h
        mov dh,[Player.Y]
        mov dl,[Player.X]
        mov al,20h
        mov bl,1Fh
        int 10h
        call _Player.CLEAR
        ret

_Player.CLEAR:
        sub [Player.X],1d
        mov ah,02h
        mov dh,[Player.Y]
        mov dl,[Player.X]
        mov bl,0Fh
        int 10h
        mov ah,09h
        mov dl,[Player.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        add [Player.X],1d
        sub [Player.Y],1d
        mov ah,02h
        mov dh,[Player.Y]
        mov dl,[Player.X]
        mov bl,0Fh
        int 10h
        mov ah,09h
        mov dl,[Player.Y]
        mov al,20h
        mov bl,0Fh
        int 10h
        add [Player.Y],1d
        add [Player.X],1d
        mov ah,02h
        mov dh,[Player.Y]
        mov dl,[Player.X]
        mov bl,0Fh
        int 10h
        mov ah,09h
        mov dl,[Player.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        sub [Player.X],1d
        add [Player.Y],1d
        mov ah,02h
        mov dh,[Player.Y]
        mov dl,[Player.X]
        mov bl,0Fh
        int 10h
        mov ah,09h
        mov dl,[Player.Y]
        mov al,20h
        mov bl,0Fh
        int 10h
        sub [Player.Y],1d
        ret

_PLAYER.UP:
        cmp [Player.Y],0d
        je _MAIN
        sub [Player.Y],1d
        ret

_PLAYER.DOWN:
        cmp [Player.Y],24d
        je _MAIN
        add [Player.Y],1d
        ret

_PLAYER.LEFT:
        cmp [Player.X],0d
        je _MAIN
        sub [Player.X],1d
        ret

_PLAYER.RIGHT:
        cmp [Player.X],79d
        je _MAIN
        add [Player.X],1d
        ret

_FOOD:
        call _FOOD.X
        mov ah,02h
        mov dh,[FOOD1.Y]
        mov dl,[FOOD1.X]
        mov al,20h
        mov bl,0Ah
        int 10
        mov ah,09h
        mov dh,[FOOD1.Y]
        mov dl,[FOOD1.X]
        mov al,20h
        mov bl,0Ah
        int 10
        mov ah,02h
        mov dh,[FOOD2.Y]
        mov dl,[FOOD2.X]
        mov al,20h
        mov bl,0Ah
        int 10
        mov ah,09h
        mov dh,[FOOD2.Y]
        mov dl,[FOOD2.X]
        mov al,20h
        mov bl,0Ah
        int 10
        mov ah,02h
        mov dh,[FOOD3.Y]
        mov dl,[FOOD3.X]
        mov al,20h
        mov bl,0Ah
        int 10
        mov ah,09h
        mov dh,[FOOD3.Y]
        mov dl,[FOOD3.X]
        mov al,20h
        mov bl,0Ah
        int 10
        mov ah,02h
        mov dh,[FOOD4.Y]
        mov dl,[FOOD4.X]
        mov al,20h
        mov bl,0Ah
        int 10
        mov ah,09h
        mov dh,[FOOD4.Y]
        mov dl,[FOOD4.X]
        mov al,20h
        mov bl,0Ah
        int 10
        mov ah,02h
        mov dh,[FOOD5.Y]
        mov dl,[FOOD5.X]
        mov al,20h
        mov bl,0Ah
        int 10
        mov ah,09h
        mov dh,[FOOD5.Y]
        mov dl,[FOOD5.X]
        mov al,20h
        mov bl,0Ah
        int 10
        call _FOOD.DOWN
        call _FOOD.CLEAR
        ret

_FOOD.DOWN:
        add [FOOD1.Y],1d
        add [FOOD2.Y],1d
        add [FOOD3.Y],1d
        add [FOOD4.Y],1d
        add [FOOD5.Y],1d
        ret

_FOOD.X:
        call _RAND.X
        mov [FOOD1.X],al
        call _RAND.X
        mov [FOOD2.X],al
        call _RAND.X
        mov [FOOD3.X],al
        call _RAND.X
        mov [FOOD4.X],al
        call _RAND.X
        mov [FOOD5.X],al
        ret

_FOOD.CLEAR:
        mov ah,02h
        sub [FOOD1.Y],1d
        mov dh,[FOOD1.Y]
        mov dl,[FOOD1.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        add [FOOD1.Y],1d
        mov ah,09h
        sub [FOOD1.Y],1d
        mov dh,[FOOD1.Y]
        mov dl,[FOOD1.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        mov ah,02h
        sub [FOOD2.Y],1d
        mov dh,[FOOD2.Y]
        mov dl,[FOOD2.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        add [FOOD2.Y],1d
        mov ah,09h
        sub [FOOD2.Y],1d
        mov dh,[FOOD2.Y]
        mov dl,[FOOD2.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        mov ah,02h
        sub [FOOD3.Y],1d
        mov dh,[FOOD3.Y]
        mov dl,[FOOD3.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        add [FOOD3.Y],1d
        mov ah,09h
        sub [FOOD3.Y],1d
        mov dh,[FOOD3.Y]
        mov dl,[FOOD3.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        mov ah,02h
        sub [FOOD4.Y],1d
        mov dh,[FOOD4.Y]
        mov dl,[FOOD4.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        add [FOOD4.Y],1d
        mov ah,09h
        sub [FOOD4.Y],1d
        mov dh,[FOOD4.Y]
        mov dl,[FOOD4.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        mov ah,02h
        sub [FOOD5.Y],1d
        mov dh,[FOOD5.Y]
        mov dl,[FOOD5.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        add [FOOD5.Y],1d
        mov ah,09h
        sub [FOOD5.Y],1d
        mov dh,[FOOD5.Y]
        mov dl,[FOOD5.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        ret

_RAND.X:
        xor al,al
        mov ah,2Ch
        int 21h
        mov ax,dx
        mov ax,0Fh
        mov al,dl
        cmp al,80d
        jg _RAND.X
        ret

_LIFE:
        mov al,[FOOD1.X]
        cmp [Player.X],al
        je _XTrue
        xor al,al
        ret

_XTrue:
        xor al,al
        mov al,[FOOD1.Y]
        cmp [Player.Y],al
        je _WIN
        ret

_WIN:
        xor al,al
        call _BACKGROUND
        mov ah,09h
        lea dx,[win]
        int 21h
        mov ah,00h
        int 16h
        jmp _QUIT

_DEFINE:

        Player.X db 40d ;Middle of consle
        Player.Y db 24d ;On bottom
        FOOD1.X db 0d
        FOOD1.Y db 0d
        FOOD2.X db 0d
        FOOD2.Y db 0d
        FOOD3.X db 0d
        FOOD3.Y db 0d
        FOOD4.X db 0d
        FOOD4.Y db 0d
        FOOD5.X db 0d
        FOOD5.Y db 0d
        PlayPrompt db 'Play again?(Y\N): $'
        win db 'WINNER!$'
        ret

_QUIT:
        call _BACKGROUND
        mov ah,09h
        lea dx,[PlayPrompt]
        int 21h
        mov ah,01h
        int 21h
        cmp al,59h
        je _STARTUP
        cmp al,79h
        je _STARTUP
        cmp al,4Eh
        je _EXIT
        cmp al,6Eh
        je _EXIT
        jmp _QUIT

_EXIT:
        int 20h
