*&---------------------------------------------------------------------*
*& Report ZFIELD_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZFIELD_PRG_05.

data: ls_data TYPE bc400_s_flight. "structure 타입으로 데이터 변수를 하나 설정해줌

PARAMETERS: iv_carr type bc400_s_flight-carrid, "select문에 조건문에 사용될 3가지 값을 입력받음
            iv_conn TYPE bc400_s_flight-connid,
            iv_flda TYPE bc400_s_flight-fldate.

*SELECT single carrid connid fldate seatsmax seatsocc "1개의 줄을 carrid connid fldate seatsmax seatsocc 필드만 받는데
SELECT SINGLE connid fldate
  from sflight "sflight 데이터 베이스로부터 받을 것이며
  into ls_data "결과를 ls_data에 넣을 것이다(이때 필드이름이 같은곳에 맵핑해줌)
  where carrid = iv_carr "조건은 입력받은 carrid, connid, fldate가 모두 일치하는 것을 고르도록 한다.(이때 이 3가지는 키값이라 3개가 모두 겹치는 경우 x)
  and connid = iv_conn
  and fldate = iv_flda.

IF sy-subrc = 0. "오류가 없으면
  cl_demo_output=>display( ls_data ). "ls_data에 넘어온 결과를 출력해서 보여준다.
ENDIF.
