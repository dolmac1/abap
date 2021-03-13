*&---------------------------------------------------------------------*
*& Include MBC410ADIAS_DYNPROTOP                                       *
*&                                                                     *
*&---------------------------------------------------------------------*

PROGRAM  sapmbc410adias_dynpro.
* screen structure
TABLES: sdyn_conn.

DATA:
* workarea for database read
  wa_sflight TYPE sflight,
* function code at PAI
  ok_code    LIKE sy-ucomm,
* radio buttons
  view VALUE 'X',
  maintain_flights,
  maintain_bookings.
DATA: DYNNR TYPE sy-dynnr. "스크린 번호 저장할 변수
TABLES: SAPLANE. "120번 스크린에 출력할 데이터를 저장할 테이블
