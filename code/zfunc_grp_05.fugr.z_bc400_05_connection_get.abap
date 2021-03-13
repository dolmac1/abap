FUNCTION Z_BC400_05_CONNECTION_GET.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CARRID) TYPE  BC400_S_CONNECTION-CARRID
*"     REFERENCE(IV_CONNID) TYPE  BC400_S_CONNECTION-CONNID
*"  EXPORTING
*"     REFERENCE(ES_CONNECTION) TYPE  BC400_S_CONNECTION
*"  EXCEPTIONS
*"      NO_DATA
*"----------------------------------------------------------------------
*방법1
SELECT single * "필드명 쓰기 귀찮을땐 corresponding fields of로 맵핑해줌  "5. db에서 조건에 맞는 한줄을 받아올 것
  from spfli "1. spfli db에서
  into CORRESPONDING FIELDS OF es_connection "2. es_connection 스트럭쳐로
  where carrid = iv_carrid "3. carrid는 입력받은 iv_carrid이고
  and connid = iv_connid. "4. connid는 입력받은 iv_connid인 것을
*주석 1 2 3 4 5번 순으로 해석하면됨

*방법2
select single carrid connid cityfrom airpfrom cityto airpto fltime deptime arrtime "5. db에서 조건에 맞는 한줄을 받아올 것
  from spfli "1. spfli db에서
  into es_connection "2. es_connection 스트럭쳐로
  where carrid = iv_carrid "3. carrid는 입력받은 iv_carrid이고
  and connid = iv_connid. "4. connid는 입력받은 iv_connid인 것을

IF sy-subrc <> 0. "만약 오류가나면
  raise no_data. "exception을 발생시킴
ENDIF.


ENDFUNCTION.
