*&---------------------------------------------------------------------*
*& Report ZSELECT_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSELECT_PRG_05.

data: ls_data TYPE bc400_s_flight, "database에서 데이터를 받아올 스트럭쳐변수
      lt_data LIKE TABLE OF ls_data. "db에서 받아온 데이터를 차례대로 저장할 테이블
PARAMETERS: pa_car TYPE bc400_s_flight-carrid. "carrid를 select 조건으로 쓰기위해서 사용할 입력받는 변수

**structure에 받아와서 table로 넣는 방법
*select * from sflight into CORRESPONDING FIELDS OF ls_data "sflight database에서 ls_data에 한줄씩 불러오는데
*  where carrid = pa_car. "carrid가 입력받은 pa_car과 같은것을 모두 불러와서 순서대로 아래의 내용 실행
*  ls_data-percentage = ls_data-seatsocc / ls_data-seatsmax * 100. "percentage 계산하고
**  write:/ ls_data-carrid,
**        ls_data-connid,
**        ls_data-fldate,
**        ls_data-percentage,
**        ls_data-seatsmax,
**        ls_data-seatsmax,
**        ls_data-seatsocc.
*  APPEND ls_data to lt_data. "internal table의 맨뒤에 넣어줌
*ENDSELECT. "조건에 맞는 모든 데이터를 처리해줬으면 select문을 종료한다.

*internal table로 바로 받아오기
select * from sflight into CORRESPONDING FIELDS OF TABLE lt_data "sflight database에서 ls_data에 한줄씩 불러오는데
  where carrid = pa_car. "carrid가 입력받은 pa_car과 같은것을 모두 불러와서 순서대로 아래의 내용 실행
  LOOP AT lt_data into ls_data. "lt_data의 percentage 필드를 계산하기 위해서 1줄부터 ls_data structure에 넣어가면서 반복
    ls_data-percentage = ls_data-seatsocc / ls_data-seatsmax * 100. "percentage 계산
    MODIFY table lt_data from ls_data. "테이블에 업데이트해줌
  ENDLOOP. "마지막줄까지 끝나면 루프문 탈출
cl_demo_output=>display( lt_data ). "internal table 출력
