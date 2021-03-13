*&---------------------------------------------------------------------*
*& Report ZSAPMEMORY_CALLED_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSAPMEMORY_CALLED_05.



data: lv_car TYPE s_carr_id.
data: ls_scarr TYPE scarr.
get PARAMETER ID 'car' field lv_car. "아밥 메모리에 올라와있는 id가 car인 lv_car 파라미터를 받아옴

SELECT SINGLE * into ls_scarr from scarr where carrid = lv_car."쿼리문으로 결과값을 받아옴

write:/ ls_scarr-carrid.
