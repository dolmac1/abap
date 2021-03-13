*&---------------------------------------------------------------------*
*& Include          MZBC410_SOLUTION_05E01
*&---------------------------------------------------------------------*
LOAD-OF-PROGRAM. "프로그램이 로드 되어질 때 행해질 것
GET PARAMETER ID: "SAP 메모리에 들어가 있는 값이 있는지 보고 받아옴ㅁ
  'CAR' FIELD SDYN_CONN-CARRID, "CAR이라는 아이디의 메모리에 들어가 있는 것을 SDYN_CONN-CARRID에 넣어줌
  'CON' FIELD SDYN_CONN-CONNID,  "CON이라는 아이디의 메모리에 들어가 있는 것을 SDYN_CONN-CONNID에 넣어줌
  'DAY' FIELD SDYN_CONN-FLDATE.  "DAY이라는 아이디의 메모리에 들어가 있는 것을 SDYN_CONN-FLDATE에 넣어줌

SELECT SINGLE * FROM sflight "메모리에서 받아온 정보들을 조건으로하여 sflight database table에서 wa_sflight로 받아옴
  into wa_sflight
  where carrid = sdyn_conn-carrid
  and connid = sdyn_conn-connid
  and fldate = sdyn_conn-fldate.
"이 INCLUDE 파일은 처음 프로그램이 로드되어질 때 행해져서 처음에 들어가면 모든 필드값들이 채워진 상태로 보여지게 하려고 wa_sflight에 미리 값을 채워주는 파일임.
