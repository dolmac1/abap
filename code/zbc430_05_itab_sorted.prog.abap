*&---------------------------------------------------------------------*
*& Report  SAPBC430S_ITAB_SORTED                                       *
*&                                                                     *
*&---------------------------------------------------------------------*
*&                                                                     *
*&                                                                     *
*&---------------------------------------------------------------------*

REPORT  ZBC430_05_ITAB_SORTED.

*Replace ## by Your group- or screennumber and
*uncomment the ABAP-coding

DATA it_flight TYPE zit_sflight05.
DATA wa_sflight TYPE sflight.


WRITE / 'Printout in tableorder of Database:'.

SELECT * FROM sflight "sflight 데이터 베이스에서
 INTO wa_sflight "wa_sflight table에 한줄씩 넣는데
 WHERE carrid = 'JL'. "조건은 이렇고
  WRITE: / wa_sflight-carrid, "들어가는 순서대로 출력해줌
           wa_sflight-connid,
           wa_sflight-fldate,
           wa_sflight-price,
           wa_sflight-currency,
           wa_sflight-planetype.
ENDSELECT.

ULINE.

SELECT * FROM sflight
 INTO TABLE it_flight
 WHERE carrid = 'JL'.
WRITE /. "들어갈때 sorted table이니까 table에 정렬된 상태로 한번에 들어감 sorted table은 append 사용 불가능

LOOP AT it_flight INTO wa_sflight. "출력
  WRITE: / wa_sflight-carrid,
           wa_sflight-connid,
           wa_sflight-fldate,
           wa_sflight-price,
           wa_sflight-currency,
           wa_sflight-planetype.
ENDLOOP.
