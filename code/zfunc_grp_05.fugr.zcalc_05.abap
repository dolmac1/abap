FUNCTION ZCALC_05.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_INT1) TYPE  I
*"     REFERENCE(IV_INT2) TYPE  I
*"     REFERENCE(IV_OP) TYPE  C
*"  EXPORTING
*"     REFERENCE(EV_RESULT) TYPE  BC400_PERC
*"----------------------------------------------------------------------
CASE IV_OP.
  WHEN '+'.
    EV_RESULT = IV_INT1 + IV_INT2.
  WHEN '-'.
    EV_RESULT = IV_INT1 - IV_INT2.
  WHEN '*'.
    EV_RESULT = IV_INT1 * IV_INT2.
  WHEN '/'.
    IF IV_INT2 = 0.
      WRITE:/ 'divide by 0'.
      ELSE.
       EV_RESULT = IV_INT1 / IV_INT2.
    ENDIF.
  WHEN OTHERS.
    write:/ 'wrong operator'.
ENDCASE.
ENDFUNCTION.
