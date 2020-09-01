org 100h

msg db "Hello!$"

mov ah,09h
lea dx,[msg]
int 21h
int 20h