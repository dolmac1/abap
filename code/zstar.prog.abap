*&---------------------------------------------------------------------*
*& Report ZSTAR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSTAR.

PARAMETERS : pa_var TYPE i.
data: gv_data TYPE i value 1.
DO pa_var TIMES.
  DO gv_data TIMES.
    write: '*'.
  ENDDO.
  gv_data = gv_data + 1.
  NEW-LINE.
ENDDO.

*
**
