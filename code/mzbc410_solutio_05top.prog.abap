*&---------------------------------------------------------------------*
*& Include MZBC410_SOLUTION_05TOP                   - Module Pool      SAPMZBC410_SOLUTION_05
*&---------------------------------------------------------------------*
PROGRAM SAPMZBC410_SOLUTION_05.

TABLES: SDYN_CONN, SCARR.

DATA: WA_FLIGHT  TYPE SFLIGHT, "데이터베이스에서 값을 받아올 테이블
      IO_COMMAND TYPE C, "X 넣으면 프로그램 종료하게 할라고 쓴 변수
      OK_CODE TYPE SY-UCOMM, "버튼 입력을 확인하기 위한 변수
      GV_MODE TYPE CHAR1 VALUE 'D'. "DISPLAY/CHANGE 모드 변경을 위한 변수

DATA: GV_TIME TYPE SY-UZEIT.
DATA: GV_MOD TYPE CHAR3. "OK_CODE를 받아와서 처리해주기위함
DATA: ST_ICON1 TYPE ICONS-TEXT. "LAYOUT에 아이콘을 넣기위해 사용할 변수(layout과 같은 이름으로 선언해줘야함)
DATA: ST_ICON2 TYPE ICONS-TEXT.
DATA: RBEX_1 VALUE 'X',
      RBEX_2,
      RBEX_3.
