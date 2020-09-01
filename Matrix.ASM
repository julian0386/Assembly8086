format mz
org 100h

bin db '010$'
lea dx,[bin]
mov ah,09h
mov bl,0Ah

_LOOP:
	int 21h
	int 10h
	jmp _LOOP

int 20h
