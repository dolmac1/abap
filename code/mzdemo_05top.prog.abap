*&---------------------------------------------------------------------*
*& Include MZDEMO_05TOP                             - Module Pool      SAPMZDEMO_05
*&---------------------------------------------------------------------*
PROGRAM SAPMZDEMO_05.

TABLES: sdyn_conn.

DATA: CHK_1 TYPE C VALUE 'X'. "체크박스 CHK_1에 체크표시를 기본적으로 되있게 하는 방법
DATA: OK_CODE TYPE SY-UCOMM. "툴바에서 들어온 값을 처리해줄 변수

DATA: WA_SPFLI TYPE SPFLI.
