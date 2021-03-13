*&---------------------------------------------------------------------*
*& Report ZHOMEWORK_1_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZHOMEWORK_1_05.

PARAMETERS : gv_input TYPE i.

IF gv_input < 50.
  write:/ 'Result is less than 50'.
elseif gv_input < 100.
  write:/ 'Result is less than 100'.
elseif gv_input >= 100.
  write:/ 'Result is greater than 100'.
ENDIF.
