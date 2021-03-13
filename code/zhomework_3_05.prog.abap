*&---------------------------------------------------------------------*
*& Report ZHOMEWORK_3_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZHOMEWORK_3_05.

PARAMETERS : pa_base TYPE i DEFAULT 2,
             pa_exp TYPE i.
data: gv_result TYPE i VALUE 1.
IF pa_exp >= 10.
  write:/ '10미만을 입력하세요.'.
ELSE.
  DO pa_exp TIMES.
    gv_result = gv_result * pa_base.
  ENDDO.
  write:/ 'result :', gv_result.
ENDIF.
