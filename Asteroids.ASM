org 100h

_STARTUP:
        call _BACKGROUND
        jmp _MAIN

_MAIN:
        call _KEYCHECK
        call _PLAYER
        call _ASTEROID
        call _LIFE
        call _DELAY
        jmp _MAIN       ;Main loop

_DELAY:
        mov ah,2Ch
        int 21h
        cmp dl,[TIME]
        jne _NOTEQ
        jmp _DELAY

_NOTEQ:
        mov [TIME],dl
        jmp _MAIN

_BACKGROUND:
        mov ah,00h
        mov al,00h
        int 10h
        mov al,03h
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
        mov al,20h
        mov bl,1Fh
        int 10h
        mov cx,01h
        mov ah,09h
        mov dh,[Player.Y]
        mov dl,[Player.X]
        mov al,20h
        mov bl,1Fh
        int 10h
        ret

_PLAYER.UP:
        cmp [Player.Y],0d
        je _MAIN
        mov ah,02h
        mov dh,[Player.Y]
        mov dl,[Player.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        mov cx,01h
        mov ah,09h
        mov dh,[Player.Y]
        mov dl,[Player.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        sub [Player.Y],1d
        call _PLAYER
        ret

_PLAYER.DOWN:
        cmp [Player.Y],24d
        je _MAIN
        mov ah,02h
        mov dh,[Player.Y]
        mov dl,[Player.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        mov cx,01h
        mov ah,09h
        mov dh,[Player.Y]
        mov dl,[Player.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        add [Player.Y],1d
        call _PLAYER
        ret

_PLAYER.LEFT:
        cmp [Player.X],0d
        je _MAIN
        mov ah,02h
        mov dh,[Player.Y]
        mov dl,[Player.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        mov cx,01h
        mov ah,09h
        mov dh,[Player.Y]
        mov dl,[Player.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        sub [Player.X],1d
        call _PLAYER
        ret

_PLAYER.RIGHT:
        cmp [Player.X],79d
        je _MAIN
        mov ah,02h
        mov dh,[Player.Y]
        mov dl,[Player.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        mov cx,01h
        mov ah,09h
        mov dh,[Player.Y]
        mov dl,[Player.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        add [Player.X],1d
        call _PLAYER
        ret

_ASTEROID:
        call _RANDGEN
        call _Asteroids.DRAW
        call _Asteroids.CLEAN
        call _Asteroids.DOWN
        ret

_Asteroids.DRAW:
        mov ah,02h
        mov dh,[Asteroid1.Y]
        mov dl,[Asteroid1.X]
        mov bl,0xCF
        int 10h
        mov cx,01h
        mov ah,09h
        mov al,20h
        mov dh,[Asteroid2.Y]
        mov dl,[Asteroid2.X]
        mov bl,0xCF
        int 10h
        mov ah,02h
        mov dh,[Asteroid3.Y]
        mov dl,[Asteroid3.X]
        mov bl,0xCF
        int 10h
        mov cx,01h
        mov ah,09h
        mov al,20h
        mov dh,[Asteroid4.Y]
        mov dl,[Asteroid4.X]
        mov bl,0xCF
        int 10h
        mov ah,02h
        mov dh,[Asteroid5.Y]
        mov dl,[Asteroid5.X]
        mov bl,0xCF
        int 10h
        ret

_Asteroids.CLEAN:
        sub [Asteroid1.Y],1d
        mov ah,02h
        mov dh,[Asteroid1.Y]
        mov dl,[Asteroid1.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        mov cx,01h
        mov ah,09h
        mov dh,[Asteroid1.Y]
        mov dl,[Asteroid1.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        add [Asteroid1.Y],1d
        sub [Asteroid2.Y],1d
        mov ah,02h
        mov dh,[Asteroid2.Y]
        mov dl,[Asteroid2.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        mov cx,01h
        mov ah,09h
        mov dh,[Asteroid2.Y]
        mov dl,[Asteroid2.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        add [Asteroid2.Y],1d
        sub [Asteroid3.Y],1d
        mov ah,02h
        mov dh,[Asteroid3.Y]
        mov dl,[Asteroid3.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        mov cx,01h
        mov ah,09h
        mov dh,[Asteroid3.Y]
        mov dl,[Asteroid3.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        add [Asteroid3.Y],1d
        sub [Asteroid4.Y],1d
        mov ah,02h
        mov dh,[Asteroid4.Y]
        mov dl,[Asteroid4.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        mov cx,01h
        mov ah,09h
        mov dh,[Asteroid4.Y]
        mov dl,[Asteroid4.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        add [Asteroid4.Y],1d
        sub [Asteroid5.Y],1d
        mov ah,02h
        mov dh,[Asteroid5.Y]
        mov dl,[Asteroid5.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        mov cx,01h
        mov ah,09h
        mov dh,[Asteroid5.Y]
        mov dl,[Asteroid5.X]
        mov al,20h
        mov bl,0Fh
        int 10h
        add [Asteroid5.Y],1d
        ret

_Asteroids.DOWN:
        add [Asteroid1.Y],1d
        add [Asteroid2.Y],1d
        add [Asteroid3.Y],1d
        add [Asteroid4.Y],1d
        add [Asteroid5.Y],1d
        ret

_RANDGEN:
        mov ah,2Ch
        int 21h
        mov ax,dx
        mov ax,0Fh
        mov al,dl
        cmp al,80d
        jg _RANDGEN
        mov [Asteroid1.X],al
        mov ah,2Ch
        int 21h
        mov ax,dx
        mov ax,0Fh
        mov al,dl
        cmp al,80d
        jg _RANDGEN
        mov [Asteroid2.X],al
        mov ah,2Ch
        int 21h
        mov ax,dx
        mov ax,0Fh
        mov al,dl
        cmp al,80d
        jg _RANDGEN
        mov [Asteroid3.X],al
        mov ah,2Ch
        int 21h
        mov ax,dx
        mov ax,0Fh
        mov al,dl
        cmp al,80d
        jg _RANDGEN
        mov [Asteroid4.X],al
        mov ah,2Ch
        int 21h
        mov ax,dx
        mov ax,0Fh
        mov al,dl
        cmp al,80d
        jg _RANDGEN
        mov [Asteroid5.X],al
        xor al,al
        ret

_LIFE:
        mov al,[Player.Y]
        cmp [Asteroid1.Y],al
        je _Ytrue
        cmp [Asteroid2.Y],al
        je _Ytrue
        cmp [Asteroid3.Y],al
        je _Ytrue
        cmp [Asteroid4.Y],al
        je _Ytrue
        cmp [Asteroid5.Y],al
        je _Ytrue
        xor al,al
        ret

_Ytrue:
        mov al,[Player.X]
        cmp [Asteroid1.X],al
        je _GameOver
        cmp [Asteroid2.X],al
        je _GameOver
        cmp [Asteroid3.X],al
        je _GameOver
        cmp [Asteroid4.X],al
        je _GameOver
        cmp [Asteroid5.X],al
        je _GameOver
        xor al,al
        ret

_GameOver:
        call _BACKGROUND
        mov ah,09h
        lea dx,[GameOver]
        int 21h
        mov ah,00h
        int 16h
        jmp _STARTUP

_QUIT:
        call _BACKGROUND
        mov ah,09h
        lea dx,[QuitPrompt]
        int 21h
        mov ah,01h
        int 21h
        cmp al,59h
        je _EXIT
        cmp al,79h
        je _EXIT
        cmp al,4Eh
        je _STARTUP
        cmp al,6Eh
        je _STARTUP
        jmp _QUIT

_EXIT:
        int 20h

_DEFINE:
        Player.X db 40d ;Middle of consle
        Player.Y db 24d ;On bottom
        Asteroid1.X db 0d
        Asteroid1.Y db 0d
        Asteroid2.X db 0d
        Asteroid2.Y db 0d
        Asteroid3.X db 0d
        Asteroid3.Y db 0d
        Asteroid4.X db 0d
        Asteroid4.Y db 0d
        Asteroid5.X db 0d
        Asteroid5.Y db 0d
        TIME db 0d
        QuitPrompt db 'Quit game?(Y\N): $'
        GameOver db 'Game Over!$'
        ret