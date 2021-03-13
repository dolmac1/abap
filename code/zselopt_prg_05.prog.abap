*&---------------------------------------------------------------------*
*& Report ZSELOPT_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSELOPT_PRG_05.

data: lt_spfli type TABLE OF spfli, "internal table 생성
      ls_spfli like LINE OF lt_spfli. "structure 생성

*select-options: so_car for ls_spfli-carrid. "조건을 option의 형태로 걸 수 있음(크거나 같다, 같다, 작다, 작거나 같다, 크다, 같지않다 등등)
"이때 so_car는 header가 있는 internal table로 생성됨

data : lv_carrid type s_carr_id,
        LV_DT TYPE DATUM.
*데이터 타입으로 만들 수도 있음
select-options: so_car for lv_carrid, "SELECT-OPTIONS를 CARRID와 FLDATE로 주기위해서 생성
                SO_DT FOR LV_DT.
INITIALIZATION. "select-options에 조건을 지정해줌
  so_car-SIGN = 'I'. "sign은 include
  so_car-option = 'EQ'. "조건은 같다
  so_car-low = 'SQ'. "값은 sq
  append so_car. "so_car의 조건 : carrid가 sq와 같은것을 포함한다.

  clear: so_car."header를 clear함
  so_car-SIGN = 'I'.
  so_car-option = 'BT'.
  so_car-low = 'AA'.
  so_car-high = 'LH'.
  append so_car. "so_car의 조건 : carrid가 aa와 lh 사이인 것을 포함한다.

  clear: so_car."header를 클리어함(안하면 high에 lh가 남아있어서 에러발생가능
  so_car-SIGN = 'E'.
  so_car-option = 'EQ'.
  so_car-low = 'JT'.
  append so_car. "so_car의 조건 : 이 때 carrid가 jt인 값은 포함하지 않는다(E는 EXCLUDE)

  clear: so_dt.
  so_dt-SIGN = 'I'.
  SO_DT-OPTION = 'EQ'.
  SO_DT-LOW = SY-DATUM+0(6) && '01'. "이번달 1일을 구함
  call function 'HR_BG_LAST_DAY_OF_MONTH' "이번달 마지막 날을 구하는 펑션 모듈
    exporting
      day_in                  = SO_DT-LOW
   IMPORTING
     LAST_DAY_OF_MONTH       = SO_DT-HIGH
            .
  APPEND SO_DT. "SO_DT의 조건을 이번달 1일부터 마지막날까지로 지정
START-OF-SELECTION.

SELECT * into CORRESPONDING FIELDS OF TABLE lt_spfli from spfli "spfli database에서 lt_spfli internal table로 데이터를 받아오는데
  where carrid in so_car. "조건은 so_car에 만족하는 것으로 함(이때 select-options로 주는 조건은 = 이 아닌 in으로 조건을 검(where carrid = so_car 안됨))
  cl_demo_output=>display( lt_spfli ).
