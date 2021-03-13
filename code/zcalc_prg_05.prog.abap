*&---------------------------------------------------------------------*
*& Report ZCALC_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCALC_PRG_05.
data : gv_max TYPE sbc400focc-seatsmax,
      gv_occ TYPE sbc400focc-seatsocc,
      gv_percentage TYPE sbc400focc-percentage,
      gv_length TYPE i,
      gv_mod type i,
       gv_string type string.
gv_max = 300.
gv_occ = 150.
gv_string = 'abcdefghijklmnopqrstuvwxyz'.
gv_percentage = gv_occ * 100 / gv_max.
gv_length = strlen( gv_string ).
gv_mod = gv_max mod gv_occ.
write:/ gv_percentage, gv_length, gv_mod.
