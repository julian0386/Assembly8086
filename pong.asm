format MZ
org 100h
jmp _Startup

Player1_Win db "Player 1 won!$"
Player2_Win db "Player 2 won!$"
LastCheck db 00h
Player1_Points db 00h
Player2_Points db 00h
Ball_X dw 320d
Ball_Y dw 240d
Ball_X_Speed dw 1d
Ball_Y_Speed dw 1d
Paddle1_X dw 30d
Paddle1_Y dw 240d
Paddle2_X dw 610d
Paddle2_Y dw 240d

_Startup:
        call _DisplayMode
        jmp _Main

_Main:
        call _Paddle1
        call _Paddle2
        call _Ball
        call _KeyCheck
        call _CollisionCheck
        call _CheckTime
        jmp _Main

_CheckTime:
        mov ax, 2Ch
        int 21h
        cmp dl, [LastCheck]
        je _CheckTime
        mov [LastCheck], dl
        xor ax, ax ;Zero ax
        ret

_DisplayMode:
        mov ah, 00h ;Set video mode
        mov al, 12h ;16 color VGA mode
        int 10h
        mov ah, 0Bh ;Set conf background
        mov bh, 00h ;Set to background
        mov bl, 00h ;Set background to black
        int 10h
        ret

_Player1_Point:
        inc [Player1_Points]
        cmp [Player1_Points], 10d
        je _Player1_Win
        jmp _Main

_Player2_Point:
        inc [Player2_Points]
        cmp [Player2_Points], 10d
        je _Player2_Win
        jmp _Main

_Player1_Win:
        call _DisplayMode
        mov ah, 09h
        lea dx, [Player1_Win]
        int 21h
        call _Pause
        jmp _Exit

_Player2_Win:
        call _DisplayMode
        mov ah, 09h
        lea dx, [Player2_Win]
        int 21h
        call _Pause
        jmp _Exit


_CollisionCheck:
        call _CheckBall_X
        call _CheckBall_Y
        call _CheckBall_Paddle
        ret

_CheckBall_X:
        cmp [Ball_X], 640d
        je _Player1_Point
        cmp [Ball_X], 0d
        je _Player2_Point
        ret

_CheckBall_Y:
        cmp [Ball_Y], 0d
        je _Y_Collision
        cmp [Ball_Y], 320d
        je _Y_Collision
        ret

_Y_Collision:
        neg [Ball_Y_Speed]
        jmp _Main

_CheckBall_Paddle:
        mov ax, [Ball_X]
        cmp ax, [Paddle1_X]
        je _Check_Y_Paddle1Collision
        cmp ax, [Paddle2_X]
        je _Check_Y_Paddle2Collision
        xor ax, ax ;Zero ax
        ret

_Check_Y_Paddle1Collision:
        mov ax, [Ball_Y]
        cmp ax, [Paddle1_Y]
        je _Paddle1Collided
        xor ax, ax ;Zero ax
        jmp _Main

_Check_Y_Paddle2Collision:
        mov ax, [Ball_Y]
        cmp ax, [Paddle2_Y]
        je _Paddle2Collided
        xor ax, ax ;Zero ax
        jmp _Main

_Paddle1Collided:
        neg [Ball_X_Speed]
        jmp _Main

_Paddle2Collided:
        neg [Ball_X_Speed]
        jmp _Main

_Ball:
        call _DisplayMode
        mov cx, [Ball_X] ;X
        mov dx, [Ball_Y] ;Y
        call _DrawBall
        mov ax, [Ball_X_Speed]
        add [Ball_X], ax
        mov ax, [Ball_Y_Speed]
        add [Ball_Y], ax
        xor ax, ax ;Zero ax
        ret

_DrawBall:
        mov ah, 0Ch ;Write pixel
        mov al, 0Fh ;White
        mov bh, 00h ;Page
        int 10h
        inc cx
        mov ax, cx
        sub ax, [Ball_X]
        cmp ax, 08d
        jng _DrawBall
        mov cx, [Ball_X]
        inc dx
        mov ax, dx
        sub ax, [Ball_Y]
        cmp ax, 08d
        jng _DrawBall
        xor ax, ax ;Zero ax
        xor ah, ah ;Zero ah
        xor al, al ;Zero al
        ret

_Paddle1:
        mov cx, [Paddle1_X]
        mov dx, [Paddle1_Y]
        call _DrawPaddle1
        ret

_DrawPaddle1:
        mov ah, 0Ch ;Write pixel
        mov al, 0Fh ;White
        mov bh, 00h ;Page
        int 10h
        inc cx
        mov ax, cx
        sub ax, [Paddle1_X]
        cmp ax, 5d
        jng _DrawBall
        mov cx, [Paddle1_X]
        inc dx
        mov ax, dx
        sub ax, [Paddle1_Y]
        cmp ax, 20d
        jng _DrawPaddle1
        xor ax, ax ;Zero ax
        xor ah, ah ;Zero ah
        xor al, al ;Zero al
        ret

_Paddle2:
        mov cx, [Paddle2_X]
        mov dx, [Paddle2_Y]
        call _DrawPaddle2
        ret

_DrawPaddle2:
        mov ah, 0Ch ;Write pixel
        mov al, 0Fh ;White
        mov bh, 00h ;Page
        int 10h
        inc cx
        mov ax, cx
        sub ax, [Paddle2_X]
        cmp ax, 5d
        jng _DrawBall
        mov cx, [Paddle2_X]
        inc dx
        mov ax, dx
        sub ax, [Paddle2_Y]
        cmp ax, 20d
        jng _DrawPaddle2
        mov ax, ax ;Zero ax
        xor ah, ah ;Zero ah
        xor al, al ;Zero al
        ret

_KeyCheck:
        mov ah, 01h ;Check if key is pressed
        int 16h
        jz _NoKey
        mov ah, 00h ;Check which key is pressed
        int 16h
        cmp al, 1Bh ;ESC key code
        je _Exit
        cmp al, 57h
        je _Player1_UP
        cmp al, 77h
        je _Player1_UP
        cmp al, 53h
        je _Player1_DOWN
        cmp al, 73h
        je _Player1_DOWN
        cmp ah, 48h
        je _Player2_UP
        cmp ah, 50h
        je _Player2_DOWN
        ret

_Player1_UP:
        sub [Paddle1_Y], 10d
        jmp _Main

_Player1_DOWN:
        add [Paddle1_Y], 10d
        jmp _Main

_Player2_UP:
        sub [Paddle2_Y], 10d
        jmp _Main

_Player2_DOWN:
        add [Paddle2_Y], 10d
        jmp _Main

_NoKey:
        jmp _Main

_Pause:
        mov ah, 01h
        int 16h
        jz _Pause
        ret

_Exit:
        int 20h