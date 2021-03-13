*&---------------------------------------------------------------------*
*& Report ZBC405_SCREEN_S1B
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_screen_s1b.
data : gs_flight TYPE dv_flights. "데이터를 받아올 structure
SELECTION-SCREEN BEGIN OF SCREEN 1100 AS SUBSCREEN. "1100번 서브 스크린
SELECT-OPTIONS: so_car FOR gs_flight-carrid, " select-options 사용
so_con FOR gs_flight-connid.
SELECTION-SCREEN END OF SCREEN 1100.

SELECTION-SCREEN BEGIN OF SCREEN 1200 AS SUBSCREEN. "1200번 서브스크린
SELECT-OPTIONS so_fld FOR gs_flight-fldate." select-options 사용
SELECTION-SCREEN END OF SCREEN 1200.

SELECTION-SCREEN BEGIN OF SCREEN 1300 AS SUBSCREEN. " 1300번 서브 스크린
PARAMETERS: pa_all RADIOBUTTON GROUP rb1," 라디오 버튼 사용
            pa_nat RADIOBUTTON GROUP rb1,
            pa_int RADIOBUTTON GROUP rb1.
SELECTION-SCREEN END OF SCREEN 1300.

SELECTION-SCREEN BEGIN OF TABBED BLOCK strip FOR 5 LINES. "tabscreen을 만들건데 한 tab당 최대 5줄씩 보여줄 수 있음
SELECTION-SCREEN TAB (20) tab1 USER-COMMAND comm1 DEFAULT SCREEN 1100. "tab1번은 1100번 스크린으로
SELECTION-SCREEN TAB (20) tab2 USER-COMMAND comm2 DEFAULT SCREEN 1200. "tab2번은 1200번 스크린으로
SELECTION-SCREEN TAB (20) tab3 USER-COMMAND comm3 DEFAULT SCREEN 1300. "tab3번은 1300번 스크린으로
SELECTION-SCREEN END OF BLOCK strip.

INITIALIZATION.
tab1 = 'Flight connections'."1번 tab의 이름 지정
tab2 = 'Flight date'."2번 tab의 이름 지정
tab3 = 'Flight type'."3번 tab의 이름 지정

strip-activetab = 'COMM2'. "프로그램 시작시 초기화면은 2번째 텝으로 보여주도록 설정
strip-dynnr = 1200.

so_car-sign = 'I'. "select options에 조건을 넣어줌
so_car-option = 'BT'.
so_car-HIGH = 'QF'.
so_car-low = 'aa'.
append so_car.
clear so_car.

so_car-sign = 'E'.
so_car-option = 'EQ'.
so_car-low = 'AZ'.
append so_car.
CLEAR SO_CAR.

START-OF-SELECTION.

CASE 'X'. "radio button의 값에 따른 case문
    WHEN PA_ALL. "radio button의 값이 pa_all에 체크됬을때(전체 선)
      SELECT * FROM dv_flights INTO gs_flight "조건에 맞는 모든 비행편을 불러옴
        WHERE carrid IN so_car "조건은 아래 3줄
          AND connid IN so_con
          AND fldate IN so_fLD.

        WRITE: / gs_flight-carrid,
                 gs_flight-connid,
                 gs_flight-fldate,
                 gs_flight-countryfr,
                 gs_flight-cityfrom,
                 gs_flight-airpfrom,
                 gs_flight-countryto,
                 gs_flight-cityto,
                 gs_flight-airpto,
                 gs_flight-seatsmax,
                 gs_flight-seatsocc.
      ENDSELECT.
    WHEN PA_nat. "radio button의 값이 pa_nat에 체크됬을때(국내선)
      SELECT * FROM dv_flights INTO gs_flight "조건에 맞는 비행편을 불러오는데
        WHERE carrid IN so_car "조건은 이 3줄이고
          AND connid IN so_con
          AND fldate IN so_fld
          AND countryto = dv_flights~countryfr. "국내선인 것(출발지 도착지가 같은 나라)

        WRITE: / gs_flight-carrid,
                 gs_flight-connid,
                 gs_flight-fldate,
                 gs_flight-countryfr,
                 gs_flight-cityfrom,
                 gs_flight-airpfrom,
                 gs_flight-countryto,
                 gs_flight-cityto,
                 gs_flight-airpto,
                 gs_flight-seatsmax,
                 gs_flight-seatsocc.
      ENDSELECT.
    WHEN pa_int."radio button의 값이 pa_int에 체크됬을때(국제선)
      SELECT * FROM dv_flights INTO gs_flight "조건에 마즌ㄴ 비행편을 불러오는데
        WHERE carrid IN so_car"조건은 3줄
          AND connid IN so_con
          AND fldate IN so_fld
          AND countryto <> dv_flights~countryfr. "국제선인 것(출발지와 도착지의 나라가 다른것)

        WRITE: / gs_flight-carrid,
                 gs_flight-connid,
                 gs_flight-fldate,
                 gs_flight-countryfr,
                 gs_flight-cityfrom,
                 gs_flight-airpfrom,
                 gs_flight-countryto,
                 gs_flight-cityto,
                 gs_flight-airpto,
                 gs_flight-seatsmax,
                 gs_flight-seatsocc.
      ENDSELECT.
  ENDCASE.
