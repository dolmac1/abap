*&---------------------------------------------------------------------*
*& Report ZCALC_SEATS_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zcalc_seats_05.
*types로 데이터 타입 정의하지 않고 바로 data문에서 structure를 구현하는 방법
data: begin of ls_data,"스트럭쳐의 이름은 ls_data로 하고
        carrid   type s_carr_id, " 스트럭쳐의 구조는 end of 스트럭쳐이름 까지로 정의한다.
        carrname type s_carrname,
        connid   type s_conn_id,
        fldate   type s_date,
        seatsmax type s_seatsmax,
        seatsocc type s_seatsocc,
        seatsdif type s_seatsmax,
      end of ls_data, "ls_data의 구조 정의 완료
      lt_data  like table of ls_data WITH NON-UNIQUE KEY carrid connid fldate, "ls_data structure와 똑같은 구조의 internal table lt_data를 만듬
      lt_scarr type table of scarr, "scarr database에서 값들을 받아올 internal table
      ls_scarr like line of lt_scarr. "lt_scarr의 workarea로 사용
parameters : lv_carr type sflight-carrid, "select 문의 조건을 걸때 사용할 변수들
             lv_conn type sflight-connid.

select * from scarr into corresponding fields of table lt_scarr. "scarr의 모든 데이터들을 lt_scarr internal table에 가져옴

select * from sflight into corresponding fields of table lt_data "sflight의 데이터를 필드명에 맞게 lt_data internal table에 가져오는데
  where carrid = lv_carr "조건은 carrid는 입력받은 iv_carr이고
  and connid = lv_conn. "connid는 입력받은 lv_conn인 줄들만 가져옴

loop at lt_data into ls_data. "lt_data table의 첫줄부터 마지막까지 하나씩 ls_data에 넣어서 작업
  clear: ls_scarr. "이전 loop문에서 들어간 정보가 있으므로 만약을 대비해서 clear해줌
  read table lt_scarr into ls_scarr with key carrid = ls_data-carrid.
  "lt_scarr 테이블에서 carrid가 현재 작업중인 ls_data의 carrid와 같은걸 ls_scarr로 가져옴
  ls_data-carrname = ls_scarr-carrname.
  ls_data-seatsdif = ls_data-seatsmax - ls_data-seatsocc.
  modify table lt_data from ls_data.
  "ls_data로 작업을 위해 가져온 lt_data의 줄에 변경된 값을 넣어줌 modify 뒤에 table이 있으면 key component 가지고 찾아가서 변경
endloop.

cl_demo_output=>display( lt_data )."화면 출력
