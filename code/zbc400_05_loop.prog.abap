*&---------------------------------------------------------------------*
*& Report ZBC400_05_LOOP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC400_05_LOOP.

*data: gt_connections TYPE TABLE OF bc400_s_connection WITH NON-UNIQUE KEY CARRID CONNID,
*      gs_connection LIKE LINE OF GT_CONNECTIONS.
"internal table인데 아래에 method 사용할 때 et_connections가 bc400_t_connections라서 데이터를 받아오려면 같은 타입이어야 하니까 bc400_t_connections로 설정
data: gt_connections type zyconnection_05, "zyconnection_05는 se11에서 직접만든 데이터 타입
      gs_connection like line of gt_connections.
*data: gs_connection type bc400_s_connection. "work area로 쓸 변수 선언
*      gt_connections type bc400_t_connections. "위에 두줄이랑 이 두줄이랑 같은 것

*try. "값을 받아오는 함수를 실행해보자
*call method cl_bc400_flightmodel=>get_connections
**  exporting 보내줄 값 없음
**    iv_carrid      = SPACE
*  importing "받아오는 값을 집어넣기 위해서 받아올 인터널 테이블 설절
*    et_connections = gt_connections
*    .
* catch cx_bc400_no_data . "데이터가 없을때는 여기로 와서 실행
*   write:/ 'no data'.
* catch cx_bc400_no_auth .
*endtry.

call method zcl_compute_05=>get_connection
  importing
    et_connections = gt_connections
.
*테이블의 정보를 받아오려면 키값까지 똑같아야 에러 안남

sort gt_connections by deptime ASCENDING. "deptime에 대해서 오름차순으로 정렬

LOOP AT gt_connections into gs_connection. "출력을 하기위해서 반복을 하는데 첫줄부터 work area로 불러와서 실행
  write:/ gs_connection-airpfrom,
          gs_connection-airpto,
          gs_connection-arrtime,
          gs_connection-carrid,
          gs_connection-cityfrom,
          gs_connection-cityto,
          gs_connection-connid,
          gs_connection-deptime,
          gs_connection-fltime.
ENDLOOP.
