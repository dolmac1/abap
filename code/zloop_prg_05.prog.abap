*&---------------------------------------------------------------------*
*& Report ZLOOP_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZLOOP_PRG_05.

data: lv_cnt TYPE i.



DO .
  add 1 to lv_cnt.
  write:/ sy-index.
*sy-index 는 루프카운트

  if sy-index = 10.
    exit.
    endif.
ENDDO.

DO 5 TIMES.
  write:/ sy-index.
*se11에 data type에 syst검색하면 나옴
ENDDO.
