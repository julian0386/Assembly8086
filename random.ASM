format mz
org 100h

_RandomGEN:
	mov ah,2Ch
	int 21h
	mov ax,dx
	mov ax,0Fh
	mov al,dl
	cmp al,30h
	jl _ADD
	cmp al,39h
	jg _SUB
	jmp _PrintNUM

_ADD:
	add al,1h
	cmp al,30h
	je _PrintNUM
	jmp _ADD

_SUB:
	sub al,1h
	cmp al,39h
	je _PrintNUM
	jmp _SUB


_PrintNUM:
	mov cx,1h
	mov ah,0Eh
	int 10h

mov ah,08h
int 21h
cmp al,1Bh
je _EXIT
jmp _RandomGEN

_EXIT:
	int 20h