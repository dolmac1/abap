*&---------------------------------------------------------------------*
*& Report ZCOND_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCOND_PRG_05.
data : gv_carrid type s_carr_id value 'aa'.

*IF gv_carrid is not INITIAL.
** if not gv_carrid is initial.이랑 같음
*  write:/ '내용이 있다 : ', gv_carrid.
*else.
*  write:/ '내용이 없다'.
*ENDIF.

IF 'lit1' ca 'ss' or gv_carrid <> 'qf'.
  write:/ gv_carrid.
ELSEIF gv_carrid = 'qf'.
  write:/ gv_carrid.
ELSE.
  write:/ 'x'.
ENDIF.
write:/ sy-tcode.
*시스템의 현재 날짜 출력
