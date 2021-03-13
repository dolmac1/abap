*&---------------------------------------------------------------------*
*& Report ZTEST_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTEST_05.

data gv_result TYPE i.

PARAMETERS: gv_base TYPE i,
            gv_exp type i.

*gv_result = ipow( base = gv_base exp = gv_exp ).

call function 'ZCALE_IPOW_05'
  exporting
    iv_base = gv_base
    iv_exp  = gv_exp
 IMPORTING
   EV_RESULT       = gv_result
  .

write :/ gv_base,'의 ',gv_exp,'승 =',gv_result.
