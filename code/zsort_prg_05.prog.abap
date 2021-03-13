*&---------------------------------------------------------------------*
*& Report ZSORT_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSORT_PRG_05.

data: gt_data type bc400_t_flights, "internal table 생성
      gs_data like LINE OF gt_data. "internal table gt_data의 workarea(테이블 조작을 위해 사용) 생성

select * into CORRESPONDING FIELDS OF table gt_data from sflight.
* 미리 정의된 database인 sflight에서(from) 필드명이 같은 필드들(corresponding fields of table)을 gt_data로(into) 가져옴

LOOP AT gt_data into gs_data. "각각의 줄마다 percentage를 구하기위해서 반복문돌림
  gs_data-percentage = gs_data-seatsocc / gs_data-seatsmax * 100. "원래의 sflight 데이터베이스에는 percentage가 없기때문에 구해서 넣어줌
 modify gt_data from gs_data index sy-tabix. "현재 꺼내온 데이터의 위치로 수정해서 다시 넣어줌
* modify table gt_data from gs_data. "-> 수업시간엔 이방법으로 함
ENDLOOP.

sort gt_data by percentage DESCENDING "percentage에 대해서는 내림차순
                carrid ASCENDING. "carrid에 대해서는 오름차순

LOOP AT gt_data into gs_data. " 출력부분
  write:/ gs_data-carrid,
          gs_data-connid,
          gs_data-fldate,
          gs_data-seatsmax,
          gs_data-seatsocc,
          gs_data-percentage.
ENDLOOP.
