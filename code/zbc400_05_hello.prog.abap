*&---------------------------------------------------------------------*
*& Report ZBC400_05_HELLO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC400_05_HELLO.

PARAMETERS pa_name  TYPE string.
write:/ text-h01.
write:/ text-a01.
write:/ 'hello world!'.
write:/ '어캐했누'(s01).
new-line.
write : 'hello',
*text symbols : 각 나라별로 보여주는 걸 ㄱ다르게 설정가능
pa_name.
*NEW-LINE 안쓰고 WRITE:/'HELLO',PA_NAME 해도\
