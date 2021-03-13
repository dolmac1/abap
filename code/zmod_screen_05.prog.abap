*&---------------------------------------------------------------------*
*& Report ZMOD_SCREEN_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZMOD_SCREEN_05.

DATA: GS_BOOK TYPE SBOOK.

PARAMETERS: PA_CAR LIKE GS_BOOK-CARRID.

SELECT-OPTIONS: SO_CON FOR GS_BOOK-CONNID,
                SO_FDT FOR GS_BOOK-FLDATE MODIF ID SEL.
PARAMETERS: PA_ID LIKE GS_BOOK-CUSTOMID MODIF ID SEL. "SEL이라는 이름으로 SELECT OPTIONS와 PARAMETERS를 묶음

AT SELECTION-SCREEN OUTPUT. "셀렉션 스크린의 출력에서
  LOOP AT SCREEN. "스크린을 돌면서
    IF screen-group1 = 'SEL'. "그룹1이 SEL이면
      SCREEN-ACTIVE = 0. "화면에서 보이지 않도록 처리
      MODIFY SCREEN. "스크린에 적용시킴
    ENDIF.
    IF SCREEN-NAME CS 'PA_CAR'. "이름이 PA_CAR인 변수를 "CS 대신 =쓰면 입력필드만 사라짐
      SCREEN-INPUT = 0. "INPUT이 안되도록 처리
      MODIFY SCREEN. "화면에 적용
    ENDIF.
    IF SCREEN-name = 'SO_CON-HIGH'. "변수의 이름이 SO_CON인 SELECT-OPTIONS의 HIGH를
      SCREEN-INPUT = 0. "INPUT이 안되도록 처리
      MODIFY SCREEN. "화면에 적용
    ENDIF.
  ENDLOOP.
