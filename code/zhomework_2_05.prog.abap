*&---------------------------------------------------------------------*
*& Report ZHOMEWORK_2_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZHOMEWORK_2_05.

PARAMETERS : pv_val TYPE i.
data : gv_result TYPE i.
DO pv_val TIMES.
  gv_result = sy-index * sy-index.
  write:/ 'result : ', sy-index, gv_result.
ENDDO.
