FUNCTION ZGET_SCARR_05.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CARRID) TYPE  S_CARR_ID
*"  EXPORTING
*"     REFERENCE(ES_SCARR) TYPE  SCARR
*"----------------------------------------------------------------------
SELECT SINGLE * FROM SCARR INTO ES_SCARR WHERE CARRID = IV_CARRID.
ENDFUNCTION.
