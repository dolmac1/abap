FUNCTION Z_BC400_05_FLIGHTLIST_GET. "unit 12 의 exercise 27
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
  data: ls_flight type bc400_s_flight. "database 에서 select문을 이용해서 한줄씩 받아올 structure 변수

refresh: et_flights.

SELECT * from sflight into CORRESPONDING FIELDS OF ls_flight "sflight에서 모든 데이터를 받아서 ls_flight에 필드에 맞게 넣는다.
  where carrid = iv_carrid "이때 조건은 carrid가 입력받은 iv_carrid이고
    and connid = iv_connid. "connid는 iv_connid인 값으로 한정한다.
  ls_flight-percentage = ls_flight-seatsocc / ls_flight-seatsmax * 100. "퍼센트 계산
  APPEND ls_flight to et_flights. "받아온 ls_flight 스트럭쳐의 값을 et_flights internal table의 맨뒤에 삽입한다.
ENDSELECT.
IF sy-subrc <> 0. "에러가 발생하면
  raise no_data. "데이터가 없다는 에러를 처리하도록 한다.
 else. "아닌경우에는
   SORT et_flights by percentage DESCENDING. "internal table을 percentage에 대해서 내림차순으로 정렬한다.
ENDIF.

ENDFUNCTION.
