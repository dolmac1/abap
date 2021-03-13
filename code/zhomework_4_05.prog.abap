*&---------------------------------------------------------------------*
*& Report ZHOMEWORK_4_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZHOMEWORK_4_05.

PARAMETERS : pa_data TYPE i.

data: gv_dan TYPE i VALUE 2,
      gv_result TYPE i.
IF pa_data < 2.
  write : '2이상의 수를 입력해주세요.'.
elseif pa_data > 9.
  write : '9이하의 수를 입력해주세요.'.
else.
  DO pa_data - 1 TIMES.
    DO 9 TIMES.
      gv_result = gv_dan * sy-index.
      write:/ gv_dan,'*',sy-index,'=', gv_result.
    ENDDO.
    gv_dan = gv_dan + 1.
    ULINE.
  ENDDO.
ENDIF.
