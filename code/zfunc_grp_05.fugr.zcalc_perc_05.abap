FUNCTION ZCALC_PERC_05.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_INT1) TYPE  I
*"     REFERENCE(IV_INT2) TYPE  I
*"  EXPORTING
*"     REFERENCE(EV_RESULT) TYPE  BC400_PERC
*"  EXCEPTIONS
*"      NO_ZERO
*"----------------------------------------------------------------------
IF IV_INT2 = 0."IMPORT 한 값 IV_INT2가 0일경우 계산을 할 수 없으므로 조건을 걸어줌
  EV_RESULT = 0."결과를 0으로 해주고
  RAISE NO_ZERO."예외 처리, EXCEPTION NO_ZERO가 결과에 출력됨
  ELSE."IN_INT2가 0이 아닐 경우에는 계산가능하므로 계산
    EV_RESULT = IV_INT1 / IV_INT2 * 100."퍼센트 계산
ENDIF.
ENDFUNCTION.
