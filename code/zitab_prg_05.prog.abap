*&---------------------------------------------------------------------*
*& Report ZITAB_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zitab_prg_05.

data: lt_flight type bc400_t_flights, "internal table의 형태로 변수 선언
      ls_flight like line of lt_flight. "ls_flight는 lt_flight의 한줄과 같은 형태의 구조체로 한다(like를 쓰면 타입이름이 아닌 원하는 형태로 선언된 변수를 넣음)
"ls_flight는 workarea로 사용
data: lt_data TYPE TABLE OF bc400_s_flight. "스트럭쳐의 필드 형태로 테이블을 사용하겠다. 스트럭쳐의 형태일 때는 table of가 꼭 써져야함

data: ls_info TYPE bc400_s_flight, "bc400_s_flight의 형태로 스트럭쳐 생성
      lt_info like table of ls_info. "스트럭쳐로 생성된 ls_info랑 같은 필드의 형태로 lt_info 테이블 생성

"ls_flight 스트럭쳐에 각각의 자리에 값을 넣음
ls_flight-carrid = 'aa'. "carrid에 aa를 넣음
ls_flight-connid = '0017'. "connid에 0017
ls_flight-fldate = sy-datum. "fldate는 오늘날짜
ls_flight-seatsmax = 300. "seatsmax는 300
ls_flight-seatsocc = 150. "seatsocc는 150
ls_flight-percentage = 50. "percentage에는 50을 넣음
*lt_flight와 ls_flight는 구조가 같은 형태로 선언되어있음
*쓰기
APPEND ls_flight to lt_flight. "lt_flight internal table에 ls_flight의 값을 집어넣음(append는 테이블의 맨 마지막 위치에 넣음)
APPEND ls_flight to lt_flight.
APPEND ls_flight to lt_flight.
APPEND ls_flight to lt_flight.
APPEND ls_flight to lt_flight.
APPEND ls_flight to lt_flight. "여러번 반복해서 넣어줄 수 있음

ls_flight-carrid = 'lh'.
ls_flight-connid = '0400'.
insert ls_flight into table lt_flight. "위치를 지정해주지 않아서 append와 마찬가지로 internal table의 맨 뒤에 삽입됨.
insert ls_flight into lt_flight index 2. "lt_flight의 2번째 index에 삽입해줌

clear: ls_flight. "ls_flight에 들어있는 값을 clear(삭제)해줌
"읽기
read TABLE lt_flight into ls_flight index 2. "lt_flight의 2번째 인덱스의 값을 ls_flight 스트럭쳐에 넣어라(변경을 위해서 가져옴)
read table lt_flight into ls_flight WITH TABLE KEY carrid = 'aa'
                                                   connid = '0017'
                                                   fldate = sy-datum. "lt_flight의 특정 값을 ls_flight로 불러가는데 조건에 맞는 줄을 가져감
* with key로 조건을 걸면 key값의 모든 component가 안와도 되지만 with table key를 쓰면 모든 키값을 조건걸어줘야함
*보통 같은게 여러개가 있으면 맨앞의 값을 가져가는데 시스템에 따라서 확실히 장담은 못함


*internal table의 삽입, 변경, 조회 등은 한번에 여러개를 처리 못하고 structure로 불러와서 처리해줘야함.(삭제는 delete 사용)
ls_flight-carrid = 'ua'.
ls_flight-connid = '0800'. " 변경을 위해서 불러온 스트럭쳐의 값을 일단 변경해줌
*변경
MODIFY lt_flight from ls_flight index 2. "lt_flight table의 index 2번의 값을 ls_flight에 지정된 값으로 변경해줌

*삭제
delete lt_flight INDEX 5. "lt_flight의 5번째 데이터 삭제(단, 전체를 삭제할 때는 clear를 사용가능)

delete lt_flight INDEX 2. "2번째 줄 삭제
*delete lt_flight where carrid = 'aa'. "carrid가 aa인 모든 줄을 삭제함(여기서 where은 조건을 써주는 것)

*출력
*LOOP AT lt_flight into ls_flight from 1 to 5. "lt_flight의 1번째 데이터부터 마지막 데이터까지 돌아가면서 ls_flight에 넣어서 loop문의 내용 실행
LOOP AT lt_flight into ls_flight where carrid = 'lh'.
  write:/ sy-tabix, "몇번째 루프인가
          ls_flight-carrid,
          ls_flight-connid,
          ls_flight-fldate,
          ls_flight-seatsmax,
          ls_flight-seatsocc,
          ls_flight-percentage. "loop문(반복문)을 돌면서 ls_flight의 내용을 출력(결국 결과는 lt_flight를 순서대로 출력하게됨)
  clear: ls_flight. "ls_flight에 할당된 값을 초기화시킴
ENDLOOP.

* CONCATENATE 'aa' 'bb' into 변수명 : aabb를 변수에 넣는다

IF sy-subrc = 0.


ENDIF.
