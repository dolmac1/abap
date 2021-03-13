*&---------------------------------------------------------------------* 13-30번
*& Report  BC400_RPT_REP_A
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
report  zbc400_05_rep_a.

data:
  gt_flights type bc400_t_flights,
  gs_flight  type bc400_s_flight.

parameters:
     pa_car type bc400_s_flight-carrid.

select-options: so_con for gs_flight-connid. "headerline을 가지고 있는 so_con 인터널 테이블 생성

initialization. "이 아래는 다음 이벤트가 올때까지는 정의부분임
  pa_car = 'AA'.

  if pa_car = 'AA'. "만약 pa_car이 aa이면
    so_con-sign = 'I'.
    so_con-option = 'BT'.
    so_con-low = '0017'.
    so_con-high = '0064'. "so_con의 조건에 0017(low)에서 0064(high) 사이를(bt) 포함하겠다(i)
    append so_con.
  elseif pa_car = 'AZ'. "pa_car이 az이면
    so_con-sign = 'I'.
    so_con-option = 'BT'.
    so_con-low = '0555'.
    so_con-high = '0790'. "so_con의 조건에 0555(low)에서 0790(high) 사이를(bt) 포함하겠다(i)
    append so_con.
  endif.
  "이때 screen에서 pa_car을 바꿔서 입력해도 initialization은 프로그램이 실행할 때 처음에 한번만 이뤄지기 때문에 so_con의 조건에 들어가있는 값을 바뀌지않음

at selection-screen.
*  if pa_car = 'AA'.
*    message 'AA항공사 이외의 항공사를 선택해주세요' type 'E'. "AA가 들어오면 에러를 발생시키는 방법
*  endif.

  submit zcalled_prg_05 with pa_car = pa_car "프로그램에서 다른 프로그램을 부를때 submit을 사용하는데
  via selection-screen "호출된 프로그램의 selection screen을 표시하겠다.
  and return. "호출한 프로그램이 끝나면 여기로 돌아오겠다.

start-of-selection. "여기 아래는 동작을 실행
  try."method 불러오는 함수를 실행해보고 오류가 나는지 확인(안나면 정상적으로 실행)
      call method cl_bc400_flightmodel=>get_flights_range "교재에서 불러오라고 한 method를 불러옴
        exporting "메소드로 내보내줄 값
          iv_carrid  = pa_car "pa_car은 변수 하나로 넘겨줌
          it_connid  = so_con[]
          " so_con은 select-op=tions를 통해서 넘겨줄 것인데 이때 it_connid가 테이블을 받아오는 것이니까 []를 써서 header가 아닌 table을 보내줌
        importing "결과값을 받아올 테이블 지정
          et_flights = gt_flights.
    catch cx_bc400_no_data . "조건에 맞는 데이터가 없을 때에는
      write:/ 'no_data'. "에러문 출력
* catch cx_bc400_no_auth .
  endtry.

*내보내는 곳
  export flight = gt_flights "gt_flight 라는 internal table을 flight라는 이름으로 메모리에 올리는데
  to memory id 'id_05'. "올린 id는 id_05로 한다.

  loop at gt_flights into gs_flight. "gt_flights에 데이터가 있으면 처음부터 끝까지 돌면서 gs_flight에 한줄씩 넣어서
    if gs_flight-percentage >= 90. "percentage가 90보다 크거나 같으면
      write:/ icon_green_light as icon. "초록색 아이콘 출력
    elseif gs_flight-percentage >= 50. "percentage가 50보다 크거나 같고 90보다 작으면
      write:/ icon_yellow_light as icon. "노란색 아이콘 출력
    else. "나머지의 경우
      write:/ icon_red_light as icon. "빨간 아이콘 출력
    endif. "아이콘은 se11에 icon database에서 확인가능

    write: gs_flight-carrid,
             gs_flight-connid,
             gs_flight-fldate,
             gs_flight-seatsmax,
             gs_flight-seatsocc,
             gs_flight-percentage."출력

  endloop.

  data : lt_icon like table of icon,
         ls_icon like line of lt_icon.
