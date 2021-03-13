*&---------------------------------------------------------------------*
*& Report ZVIEW_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zview_prg_05.
data: begin of ls_data,"스트럭쳐의 이름은 ls_data로 하고
        carrid   type s_carr_id, " 스트럭쳐의 구조는 end of 스트럭쳐이름 까지로 정의한다.
        carrname type s_carrname,
        connid   type s_conn_id,
        fldate   type s_date,
        seatsmax type s_seatsmax,
        seatsocc type s_seatsocc,
        seatsdif type s_seatsmax,
      end of ls_data, "ls_data의 구조 정의 완료
      lt_data like table of ls_data.

parameters: pa_car type bc400_s_flight-carrid,
            pa_con type bc400_s_flight-connid.

*view를 만들어서 그 view에서 받아오는법(view는 se11에서 만듬)
*select * from zvflight_05 into corresponding fields of TABLE lt_data
*  where carrid = pa_car
*  and connid = pa_con.

*inner join을 사용하는 방법
select * into corresponding fields of table lt_data "lt_data internal table에 받아오는데
  from sflight as a inner join scarr as b "sflight database와 scarr을 inner join 해서 받아오는데(여기서 as 는 별칭을 만들때 사용)
  on a~carrid = b~carrid "sflight의 carrid와 scarr의 carrid가 같은 것으로 inner join을함
  where a~carrid = pa_car "이때 가져오는 조건은 carrid가 pa_car이고
  and a~connid = pa_con. "connid가 pa_con인것을 가져옴(join문에서는 -로 연결하는게 아닌 ~로 연결(문법임))
cl_demo_output=>display( lt_data ).
