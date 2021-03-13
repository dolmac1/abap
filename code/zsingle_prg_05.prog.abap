*&---------------------------------------------------------------------*
*& Report ZSINGLE_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSINGLE_PRG_05.

data: ls_scarr TYPE scarr.
"transparent table은 스트럭쳐 타입으로 사용가능
PARAMETERS pa_car TYPE scarr-carrid. "select 문에서 조건으로 사용할 변수 선언
select single * from scarr into ls_scarr where carrid = pa_car. "scarr 테이블에서 carrid가 입력받은 pa_car인 줄을 ls_scarr에 넣어줌

cl_demo_output=>display( ls_scarr ). "ls_scarr의 모든 필드 출력
