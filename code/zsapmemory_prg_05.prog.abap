*&---------------------------------------------------------------------*
*& Report ZSAPMEMORY_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSAPMEMORY_PRG_05.

PARAMETERS: pa_car TYPE s_carr_id.

set PARAMETER ID 'car' field pa_car. "입력받은 pa_car 파라미터를 아밥 메모리 영역에 올림(id 는 car로 함)