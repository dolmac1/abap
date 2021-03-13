*&---------------------------------------------------------------------*
*& Report ZBC400_05_STRUCTURE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC400_05_STRUCTURE.

PARAMETERS: pa_car type bc400_s_flight-carrid,
           pa_date type bc400_s_flight-fldate,
           pa_con type bc400_s_flight-connid.
*입력값 생성 unit11-excercise23-task1-2번

data: gs_carrier type bc400_s_carrier,
      gs_flight TYPE bc400_s_flight.
*두개의 메소드를 통해 입력받을 structure 생성 unit11-excercise23-task2-1번

types : BEGIN OF gs_cf,
  carrid type s_carr_id,
  connid TYPE s_conn_id,
  fldate TYPE s_date,
  seatsmax TYPE s_seatsmax,
  seatsocc TYPE s_seatsocc,
  percentage TYPE s_flghtocc,
  carrname TYPE s_carrname,
  currcode TYPE s_currcode,
  url TYPE s_carrurl,
END OF gs_cf.
*bc400_s_carrier와 bc400_s_flight의 모든 components를 갖는 structure 생성 unit11-excercise23-task2-2번

data: gs_carrierflight TYPE gs_cf.
*만든 structure를 타입으로 갖는 structure 변수 생성 unit11-excercise23-task2-2번

try.
call method cl_bc400_flightmodel=>get_carrier
  exporting
    iv_carrid  = pa_car
  importing
    es_carrier = gs_carrier
    .
 catch cx_bc400_no_data .
 catch cx_bc400_no_auth .
endtry.
*get_carrier 메소드를 이용하여 gs_carrier로 값들을 불러옴 unit11-excercise23-task3-1번


try.
call method cl_bc400_flightmodel=>get_flight
  exporting
    iv_carrid = pa_car
    iv_connid = pa_con
    iv_fldate = pa_date
  importing
    es_flight = gs_flight
    .
 catch cx_bc400_no_data .
 catch cx_bc400_no_auth .
endtry.
*get_flight 메소드를 이용하여 gs_flight로 값들을 불러옴 unit11-excercise23-task3-1번

MOVE-CORRESPONDING gs_carrier to gs_carrierflight. "gs_carrier에 있는 값을 gs_carrierflight의 필드명이 같은 곳이 있으면 복사해와줌
MOVE-CORRESPONDING gs_flight to gs_carrierflight. "gs_flight에 있는 값을 gs_carrierflight의 필드명이 같은 곳이 있으면 복사해옴
*unit11-excercise23-task3-2번

IF gs_carrierflight is not initial.
  write:/ gs_carrierflight-carrid,
          gs_carrierflight-connid,
          gs_carrierflight-fldate,
          gs_carrierflight-seatsmax,
          gs_carrierflight-seatsocc,
          gs_carrierflight-percentage,
          gs_carrierflight-carrname,
          gs_carrierflight-currcode,
          gs_carrierflight-url.

ENDIF.
*내용이 있으면 출력
