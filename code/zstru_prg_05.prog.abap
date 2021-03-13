*&---------------------------------------------------------------------*
*& Report ZSTRU_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSTRU_PRG_05.
types: BEGIN OF ts_info,  "ts_info 라는 structure 타입을 생성
  carrid TYPE s_carr_id, "structure 안에 들어갈 변수들을 정의
  carrname TYPE s_carrname,
  connid TYPE s_conn_id,
  fldate TYPE s_date,
  percentage TYPE p LENGTH 3 DECIMALS 2,
END OF ts_info. "structure 정의를 끝냄
*모양
*ㅣ--------------------------------------------------ㅣ
*ㅣ carrid / carrname / connid / fldate / percentage ㅣ
*ㅣ--------------------------------------------------ㅣ
*ㅣ        /          /        /        /            ㅣ
*ㅣ--------------------------------------------------ㅣ
data: gs_info type ts_info.
data: gs_flight TYPE bc400_s_flight. "structure 타입으로 변수를 선언
gs_flight-carrid = 'aa'. "gs_flight(스트럭쳐로 선언된 데이터)의 carrid 필드에 aa를 넣음
gs_flight-connid = '0017'. "gs_flight의 connid 필드에 0017을 넣음
gs_flight-fldate = sy-datum.
gs_flight-seatsmax = 300.
gs_flight-seatsocc = 150.
gs_flight-percentage = '50'.

MOVE-CORRESPONDING gs_flight to gs_info.
*ㅣ------------------------------------------------------------ㅣ se11에서 확인가능
*ㅣ carrid / connid / fldate / seatsmax / seatsocc / percentageㅣ
*ㅣ------------------------------------------------------------ㅣ
*ㅣ  aa    /  0017  /sy-datum/ 300      /   150    /      50   ㅣ
*ㅣ------------------------------------------------------------ㅣ
write:/ gs_flight-carrid, gs_flight-connid, gs_flight-fldate, gs_flight-seatsmax, gs_flight-seatsocc, gs_flight-percentage.
write:/ gs_info-carrid, gs_info-carrname, gs_info-connid, gs_info-fldate, gs_info-percentage.

IF sy-subrc = 0.

ENDIF.
