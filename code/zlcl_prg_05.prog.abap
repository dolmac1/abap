*&---------------------------------------------------------------------*
*& Report ZLCL_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZLCL_PRG_05.
*클래스 정의
CLASS lcl_computer_05 DEFINITION.
  PUBLIC SECTION.
  CLASS-METHODS get_percentage
    IMPORTING iv_act TYPE i
              iv_max TYPE i
    EXPORTING ev_result TYPE bc400_perc.
*  CLASS-METHODS get_data  "여러개의 method 정의 가능
*    IMPORTING iv_carrid TYPE s_carr_id
*    EXPORTING ev_name TYPE s_carrname.
ENDCLASS.
*클래스 구현
CLASS lcl_computer_05 IMPLEMENTATION.
  METHOD get_percentage. "정의부분에서 정의한 매소드에 관해서 어떤 동작을 할지 설정
    IF iv_max = 0.
      ev_result = 0.
    ELSE.
      ev_result = iv_act / iv_max * 100.
    ENDIF.
  ENDMETHOD.

*  METHOD get_data.
*
*  ENDMETHOD.
ENDCLASS.

data : gv_result TYPE bc400_perc.

START-OF-SELECTION.
*클래스 호출
call METHOD lcl_computer_05=>get_percentage
  EXPORTING
    iv_act = 2
    iv_max = 3
  IMPORTING
    ev_result = gv_result.
