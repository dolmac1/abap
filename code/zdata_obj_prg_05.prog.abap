*&---------------------------------------------------------------------*
*& Report ZDATA_OBJ_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDATA_OBJ_PRG_05.

TYPES tv_perc TYPE p LENGTH 3 DECIMALS 2.

data : gv_perc TYPE tv_perc,
      gv_num1 TYPE i value 17,
      gv_num2 like gv_num1,
      gv_city TYPE c LENGTH 15,
      gv_carrid TYPE s_carr_id,
      gv_connid TYPE s_conn_id.

gv_perc = 1000.
