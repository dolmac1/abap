*&---------------------------------------------------------------------*
*& Report ZSORT_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZHEADER_ITAB_PRG_05.

data: gt_data type bc400_t_flights WITH HEADER LINE. "headerline을 가지고 있는 internal table 생성

select * into CORRESPONDING FIELDS OF table gt_data from sflight.
* 미리 정의된 database인 sflight에서(from) 필드명이 같은 필드들(corresponding fields of table)을 gt_data로(into) 가져옴

LOOP AT gt_data. "각각의 줄마다 percentage를 구하기위해서 반복문돌림(headerline으로 수정) - 여기의 gt_data는 headerline 의미
  gt_data-percentage = gt_data-seatsocc / gt_data-seatsmax * 100. "원래의 sflight 데이터베이스에는 percentage가 없기때문에 구해서 넣어줌
 modify gt_data. "headerline으로 꺼내온 데이터를 원래 위치로 수정해서 다시 넣어줌 - 여기의 gt_data는 internal table
ENDLOOP.

sort gt_data by percentage DESCENDING "percentage에 대해서는 내림차순
                carrid ASCENDING. "carrid에 대해서는 오름차순

*clear: gt_data. "header line의 내용 삭제
*clear: gt_data[]. "internal table의 내용 삭제

LOOP AT gt_data. " 출력부분 - header line에 맨앞부터 넣어가면서 반복 실행
  write:/ gt_data-carrid, "headerline에 들어간 값을 출력하는 것임
          gt_data-connid,
          gt_data-fldate,
          gt_data-seatsmax,
          gt_data-seatsocc,
          gt_data-percentage.
ENDLOOP.
