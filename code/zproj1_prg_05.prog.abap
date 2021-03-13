*&---------------------------------------------------------------------*
*& Report ZEX1_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zproj1_prg_05.

PARAMETERS: gv_carr TYPE sbook-carrid, "airline
            gv_conn TYPE sbook-connid, "connection number
            gv_fldt TYPE sbook-fldate. "flight date
*select 문에 조건을 걸어줄 변수들을 받아옴
*goto - text element - selection texts 에서 이름 지정해줄 수 있음

TYPES : BEGIN OF gs_fl, "출력필드 정의 부분
          carrid     TYPE sbook-carrid,
          carrname   TYPE scarr-carrname,
          connid     TYPE sbook-connid,
          fldate     TYPE sbook-fldate,
          bookid     TYPE sbook-bookid,
          customid   TYPE sbook-customid,
          name       TYPE scustom-name,
          telephone  TYPE scustom-telephone,
          custtype   TYPE sbook-custtype,
          loccuram   TYPE sbook-loccuram,
          loccurkey  TYPE sbook-loccurkey,
          order_date TYPE sbook-order_date,
          days       TYPE int4,
          cancelled  TYPE sbook-cancelled,
        END OF gs_fl.
*select문을 통해서 정보들을 받아올 테이블의 타입을 정의함

DATA: gt_flgt TYPE TABLE OF gs_fl,
      gs_flgt LIKE LINE OF gt_flgt.
"위에서 정의한 타입으로 테이블과 workarea를 정의함
DATA: ch_loccur TYPE c LENGTH 10.
*나중에 통화 변경해서 금액 출력할 때 사용할 변수
data: gv_cur TYPE p LENGTH 5 DECIMALS 2.

SELECT * INTO CORRESPONDING FIELDS OF TABLE gt_flgt
  FROM sbook INNER JOIN scustom ON sbook~customid = scustom~id "고객 이름과 고객 전화번호를 받아오기 위해서 scustom과 inner join
  INNER JOIN scarr ON scarr~carrid = sbook~carrid "항공사명을 받아오기 위해서 scarr과 inner join
  WHERE sbook~carrid = gv_carr
  AND sbook~connid = gv_conn
  AND sbook~fldate = gv_fldt.
*gt_flgt 테이블로 자료들을 sbook database에서 불러오는데 scustom과 inner join을 통해서(조건은 id가 같은 것끼리 묶음), scarr과도 inner join을 통해(조건은 carrid가 같은 것끼리)
*묶어서 하나의 테이블로 만드는데 이때 받아올 데이터들의 조건을 where문을 통해서 지정해줌
IF gt_flgt IS INITIAL. "테이블에 데이터가 없으면 조건에대한 정보가 없는 것이므로
  MESSAGE '예약 정보가 존재하지 않습니다.' TYPE 'E'. "에러 메시지 출력
  "메시지의 타입을 E로 해주면 에러 발생시 입력하는 곳에서 넘어가지 못함.
ELSE. "테이블에 데이터가 있으면
  LOOP AT gt_flgt INTO gs_flgt.
    CALL FUNCTION 'HR_99S_INTERVAL_BETWEEN_DATES' "예약한 날짜와 비행 날짜의 차이를 구해주는 function module
      EXPORTING
        begda    = gs_flgt-order_date "주문일자
        endda    = gs_flgt-fldate "비행날짜
        tab_mode = ' '
      IMPORTING
        days     = gs_flgt-days. "결과를 받아올 곳
    MODIFY gt_flgt FROM gs_flgt. "각 줄별로 돌면서 비행날짜와 주문일자의 차를 구해서 WORKAREA에 넣었으니 다시 GT_FLGT TABLE로 넣어줌
  ENDLOOP.
  LOOP AT gt_flgt INTO gs_flgt. "internal table의 내용을 출력
    WRITE gs_flgt-loccuram TO ch_loccur CURRENCY gs_flgt-loccurkey. "통화를 우리가 원하는 통화에 맞게 출력하기위한 방법(GS_FLGT의 LOCCURKEY가 바뀌면 그에 맞게 출력
    WRITE:/
      gs_flgt-carrid,
      gs_flgt-carrname,
      gs_flgt-connid,
      gs_flgt-fldate,
      gs_flgt-bookid,
      gs_flgt-customid,
      gs_flgt-name,
      gs_flgt-telephone,
      gs_flgt-custtype,
      ch_loccur, "다른데는 TABLE에 저장되어 있는 값을 불러서 출력하지만 가격은 우리가 통화에 맞게 변경한 값을 출력
      gs_flgt-loccurkey,
      gs_flgt-order_date,
      gs_flgt-days,
      gs_flgt-cancelled.

  ENDLOOP.
ENDIF.
