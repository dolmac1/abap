*&---------------------------------------------------------------------*
*& Report ZTABSTRIP_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztabstrip_prg_05.

DATA: gs_flight TYPE sflight.

SELECTION-SCREEN BEGIN OF SCREEN 110 AS SUBSCREEN. "110번 subscreen 정의
PARAMETERS : pa_car TYPE sflight-carrid,
             pa_con TYPE sflight-connid.
SELECTION-SCREEN END OF SCREEN 110.

SELECTION-SCREEN BEGIN OF SCREEN 120 AS SUBSCREEN. "120번 subscreen 정의
SELECT-OPTIONS : so_fdt FOR gs_flight-fldate.
SELECTION-SCREEN END OF SCREEN 120.

SELECTION-SCREEN BEGIN OF SCREEN 130 AS SUBSCREEN. "130번 subscreen 정의
PARAMETERS: pa_id  TYPE sbook-customid,
            pa_all RADIOBUTTON GROUP rb1,
            pa_nat RADIOBUTTON GROUP rb1,
            pa_int RADIOBUTTON GROUP rb1.
SELECTION-SCREEN END OF SCREEN 130.

SELECTION-SCREEN BEGIN OF TABBED BLOCK strip FOR 5 LINES. "strip라는 이름의 tab screen을 정의함 (각각의 tab은 5줄까지 한번에 보여줌)
SELECTION-SCREEN TAB (20) tab1 USER-COMMAND comm1 DEFAULT SCREEN 110. "첫번째 텝은 tab1이라는 이름으로 길이는 20이고 110번 스크린을 띄워줌
SELECTION-SCREEN TAB (20) tab2 USER-COMMAND comm2 DEFAULT SCREEN 120. "두번째 텝은 tab2이라는 이름으로 길이는 20이고 120번 스크린을 띄워줌
SELECTION-SCREEN TAB (20) tab3 USER-COMMAND comm3 DEFAULT SCREEN 130. "세번째 텝은 tab3이라는 이름으로 길이는 20이고 130번 스크린을 띄워줌
SELECTION-SCREEN END OF BLOCK strip.

INITIALIZATION.
  tab1 = 'Connection'. "각각의 tab page의 이름을 지정해줌
  tab2 = 'Flights'.
  tab3 = 'Booking'.
  strip-activetab = 'COMM3'. "3번째 텝이 처음에 기본으로 보여지도록함(무조건 대문자로 써줘야함)
  strip-dynnr = 130. "3번째 텝의 스크린번호
*  strip-activetab = 'COMM2'. "2번째 텝이 처음에 기본으로 보여지도록함(무조건 대문자로 써줘야함)
*  strip-dynnr = 120. "2번째 텝의 스크린번호
*
START-OF-SELECTION.
  SELECT SINGLE * INTO gs_flight "gs_flight에 조건에 맞는 한 줄의 데이터를 받아오는데
    FROM sflight "sflight에서 가져오며
    WHERE carrid = pa_car "조건은 아래 3줄과 같다
    AND connid = pa_con
    AND fldate IN so_fdt.

  WRITE:/ gs_flight-carrid, "출력
          gs_flight-connid,
          gs_flight-fldate,
          gs_flight-seatsmax,
          gs_flight-seatsocc.
