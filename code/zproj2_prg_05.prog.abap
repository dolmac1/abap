*&---------------------------------------------------------------------*
*& Report ZPROJ2_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zproj2_prg_05.

DATA: gv_air  TYPE spfli-carrid, "select-options을 받을 변수
      gs_flgt TYPE zsflight_05, "gs_sche의 flight 테이블(deep structure)에 값을 넣기위한 work-area
      gt_sche TYPE zyschedule_05, "데이터를 저장할 테이블
      gs_sche LIKE LINE OF gt_sche. "gt_sche의 work-area
SELECTION-SCREEN begin of BLOCK block1 with FRAME TITLE text-t01.
  SELECT-OPTIONS: so_air FOR gv_air. "select options으로 gv_air의 조건을 받음
SELECTION-SCREEN END OF block block1.


INITIALIZATION. "select-options의 정의를 위해서 사용
  so_air-sign = 'I'. "include 한다
  so_air-option = 'EQ'. "low부분과 같은것
  so_air-low = 'AA'. "즉, carrid가 aa와 같은 것을 include
  APPEND so_air. "select options을 넣어줌

  so_air-sign = 'I'. "위와 같음(carrid만 ua로)
  so_air-option = 'EQ'.
  so_air-low = 'UA'.
  APPEND so_air.

START-OF-SELECTION. "프로그램 동작은 여기부터 실행
  SELECT * INTO CORRESPONDING FIELDS OF gs_sche "gs_sche에 필드명에 맞게 넣는데
  FROM spfli INNER JOIN scarr ON spfli~carrid = scarr~carrid "spfli와 scarr을 carrid로 묶어서 inner join해서 넣고
  WHERE spfli~carrid IN so_air. "carrid가 so_air에 포함되는 것만 넣음
    SELECT * FROM sflight INTO CORRESPONDING FIELDS OF gs_flgt "gs_sche의 flight table에 넣을 값들을 gs_flgt table에 받아와서 넣을 준비를 함
    WHERE carrid = gs_sche-carrid
    AND connid = gs_sche-connid.
      APPEND gs_flgt TO gs_sche-flight. "gs_flgt를 gs_sche-flight에 넣어줌
      CLEAR : gs_flgt.
    ENDSELECT.
    APPEND gs_sche TO gt_sche. "select문을 통해 받아온 gs_sche를 한 줄씩 gt_sche에 넣어줌
    CLEAR : gs_sche.
  ENDSELECT.
  SORT gt_sche BY carrid ASCENDING. "carrid를 기준으로 오름차순으로 정렬하기위해서 사용(보기 편하게 하기위해서)

  LOOP AT gt_sche INTO gs_sche. "gt_sche를 출력해주기 위해서 gs_sche에 한줄씩 넣는데
    FORMAT COLOR 1 ON. "줄의 배경색을 1번을 넣어줌
    WRITE:/ icon_flight AS ICON, "비행기 아이콘 출력
            gs_sche-carrid, "내용물 출력(deep structure 이외의 값들을 먼저)
            gs_sche-carrname,
            gs_sche-connid,
            gs_sche-countryfr,
            gs_sche-cityfrom,
            gs_sche-airpfrom,
            gs_sche-countryto,
            gs_sche-cityto,
            gs_sche-airpto.
    FORMAT COLOR 1 OFF. "여기까지만 1번 배경색을 넣겠다
    LOOP AT gs_sche-flight INTO gs_flgt. "gs_sche안의 flight table을 출력하기위해서 gs_flgt에 넣음
      FORMAT COLOR 2 ON. "줄의 배경색을 2번을 넣어줌
      WRITE:/ gs_flgt-fldate, "deep structure 안의 테이블의 내용물을 출력
              gs_flgt-price,
              gs_flgt-currency,
              gs_flgt-planetype,
              gs_flgt-seatsmax,
              gs_flgt-seatsocc,
              gs_flgt-paymentsum.
      FORMAT COLOR 2 OFF. "2번 배경색을 출력하는것을 끝냄
    ENDLOOP.
  ENDLOOP.
