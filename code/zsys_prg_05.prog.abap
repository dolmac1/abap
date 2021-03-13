*&---------------------------------------------------------------------*
*& Report ZSYS_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSYS_PRG_05.

data gs_scarr type scarr.
PARAMETERS pa_carr type scarr-carrid.

*select single * from scarr into gs_scarr where carrid = pa_carr.

call function 'ZGET_SCARR_05'
  exporting
    iv_carrid       = PA_CARR
 IMPORTING
   ES_SCARR        = GS_SCARR
          .


IF sy-subrc = 0.
*sy-subrc는 바로 이전의 명령이 참이면 0 거짓이면 다른 숫자가옴
  write:/ gs_scarr-carrid, gs_scarr-carrname, gs_scarr-url.
  else.
    write:/'없다'.
ENDIF.
