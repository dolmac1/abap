FUNCTION ZGET_AGE_05.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_BIRDT) TYPE  DATS
*"  EXPORTING
*"     REFERENCE(EV_AGE1) TYPE  I
*"     REFERENCE(EV_AGE2) TYPE  I
*"----------------------------------------------------------------------
EV_AGE1 = SY-DATUM+0(4) - IV_BIRDT+0(4) + 1. "DATS+0(4)를 하면 연도를 출력해주니까 오늘의 년도 - 생년의 년도 + 1을 해서 나이를 구해줌
IF SY-DATUM+4(4) - IV_BIRDT+4(4) >= 0. "DATS+4(4)를 하면 월,일을 출력해주니까 생일이 오늘 이후(지난경우)에는 만나이는 나이보다 한살 적으므로
  EV_AGE2 = EV_AGE1 - 1. "나이에서 1을 빼서 만 나이를 구하고
ELSE. "생일이 안지난 경우에는
  EV_AGE2 = EV_AGE1 - 2. "나이에서 2를 빼서 만 나이를 구함
ENDIF.
ENDFUNCTION.
