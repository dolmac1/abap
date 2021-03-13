*&---------------------------------------------------------------------*
*& Report ZVALUE_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zvalue_prg_05.

data : gv_carrid1 type s_carr_id,
       gv_carrid2 type s_carr_id value 'LH',
       gv_cnt type i.
write:/ gv_carrid1, gv_carrid2, gv_cnt.
constants: gc_qf type s_carr_id value 'QF'.
move gc_qf to gv_carrid1.
write:/ gv_carrid1, gv_carrid2, gv_cnt.
gv_carrid2 = gv_carrid1.
write:/ gv_carrid1, gv_carrid2, gv_cnt.
gv_cnt = gv_cnt + 1.
*add 1 to gv_cnt.도 똑같다
write:/ gv_carrid1, gv_carrid2, gv_cnt.
clear: gv_carrid1,
      gv_carrid2,
      gv_cnt.
write:/ gv_carrid1, gv_carrid2, gv_cnt.
