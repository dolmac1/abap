FUNCTION ZCALE_IPOW_05.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_BASE) TYPE  I
*"     REFERENCE(IV_EXP) TYPE  I
*"  EXPORTING
*"     REFERENCE(EV_RESULT) TYPE  I
*"----------------------------------------------------------------------

ev_result = ipow( base = iv_base exp = iv_exp ).



ENDFUNCTION.
