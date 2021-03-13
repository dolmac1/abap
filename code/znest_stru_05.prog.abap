*&---------------------------------------------------------------------*
*& Report ZNEST_STRU_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT znest_stru_05.
DATA: gs_emp TYPE zsemp_05, "nested structure로 변수 선언
      gs_emp1 TYPE zsemp1_05.
gs_emp-pernr = 1000001.
gs_emp-dept-orgeh = 11000. "스트럭쳐 안에 스트럭쳐가 들어가있으면 -로 또 연결해주면 됨
gs_emp-dept-orgtx = '재경팀'. "gs_emp structure안의 dept structure의 orgtx에 값을 넣음

gs_emp1-pernr = 1000001.
gs_emp1-orgeh = 11000. ".include 스트럭쳐를 사용하면 호출할 때 aa-bb-cc로 안하고 바로 aa-cc로 가능
gs_emp1-orgtx = '재경팀'.

WRITE:/ gs_emp-pernr,
        gs_emp-dept-orgeh,
        gs_emp-dept-orgtx.

write:/ gs_emp1-pernr,
        gs_emp1-orgeh,
        gs_emp1-orgtx.
