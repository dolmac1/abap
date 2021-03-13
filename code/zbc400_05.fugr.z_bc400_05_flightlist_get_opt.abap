FUNCTION Z_BC400_05_FLIGHTLIST_GET_OPT. " unit 12 의 exercise 28
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CARRID) TYPE  BC400_S_FLIGHT-CARRID
*"     REFERENCE(IV_CONNID) TYPE  BC400_S_FLIGHT-CONNID
*"  EXPORTING
*"     REFERENCE(ET_FLIGHTS) TYPE  BC400_T_FLIGHTS
*"  EXCEPTIONS
*"      NO_DATA
*"----------------------------------------------------------------------
data: ls_flight type bc400_s_flight. "workarea 생성

refresh: et_flights. "et_flights가 깨끗한 상태가 되도록 비워줌

SELECT * from sflight into CORRESPONDING FIELDS OF TABLE et_flights "sflight database에서 et_flights table로 필드에 맞게 값을 받아오는데
  where carrid = iv_carrid "조건은 carrid가 iv_carrid이고
  and connid = iv_connid. "connid가 iv_connid인 줄만 받아온다.

IF sy-subrc <> 0. "에러가 발생하면
  raise no_data. "no_data를 발생시킴
 else. " 에러가 없을 경우에는
   LOOP AT et_flights into ls_flight. "et_flights internal table의 1줄부터 workarea인 ls_flight에 넣어가면서
     ls_flight-percentage = ls_flight-seatsocc / ls_flight-seatsmax * 100. "퍼센테이지를 계산하고
     MODIFY et_flights from ls_flight "ls_flight에 계산된 값을 다시 et_flights에 넣는데
     TRANSPORTING percentage. "transporting을 쓰면 우리가 계산한 값인 percentage만 바꿔주라고 할 수 있어서 조금 더 빠름
   ENDLOOP. "마지막 줄까지 완료하고 종료
   SORT et_flights by percentage DESCENDING. "percentage에 대해서 내림차순으로 정렬
ENDIF.

ENDFUNCTION.
