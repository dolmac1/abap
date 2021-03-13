*&---------------------------------------------------------------------*
*& Include          MZBC410_SOLUTION_05O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module MOVE_TO_DATA OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE move_to_data OUTPUT. "데이터를 출력을 위한 테이블에 넣는 모듈
  IF gv_mod = 'CRT'.
    CLEAR:wa_flight.
    CLEAR: gv_mod.
  ENDIF.
  MOVE-CORRESPONDING wa_flight TO sdyn_conn. "WA_FLIGHT로 받아온 테이블을 SDYN_CONN으로 넣어줌

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module MODIFY_SCREEN OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE modify_screen OUTPUT. "스크린을 DISPLAY/CHANGE 모드 변경을 위한 모듈
  LOOP AT SCREEN. "스크린에서 계속 반복
    IF screen-group1 = 'MOD'. "스크린 그룹1이 MOD이면
      IF gv_mode = 'C'. "GV_MODE가 C일때는 INPUT 가능
        screen-input = 1.
      ELSEIF gv_mode = 'D'. "GV_MODE가 D일때는 INPUT 불가능
        screen-input = 0.
      ENDIF.

    ENDIF.
    MODIFY SCREEN.
  ENDLOOP.
     IF rbex_2 = 'X'. "만약에 RBEX_2번 RADIOBUTTON이 눌리면
     LOOP AT SCREEN. "스크린을 돌면서
      IF screen-name = 'SDYN_CONN-PLANETYPE'. "이름이 이거인 필드를
        screen-input = 1. "입력모드로 바꿔줌
        MODIFY SCREEN. "스크린에 적용
      ENDIF.
    ENDLOOP.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module GET_DATA OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE get_data OUTPUT.
  SELECT SINGLE *
    FROM scarr
    WHERE carrid = sdyn_conn-carrid.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0150 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0150 OUTPUT.
  SET PF-STATUS 'S150'.
  SET TITLEBAR 'T02'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0110 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0110 OUTPUT.
  SET PF-STATUS 'S1102'.
  SET TITLEBAR 'T110'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S100'.
* SET TITLEBAR 'T100' with sy-uname.
  CASE 'X'.
      WHEN rbex_1.
      SET TITLEBAR 'T100' WITH 'DISPLAY'.
      WHEN rbex_2.
      SET TITLEBAR 'T100' WITH 'MAINTAIN FLIGHTS'.
    WHEN rbex_3.
      SET TITLEBAR 'T100' WITH 'MAINTAIN BOOKINGS'.
      WHEN OTHERS.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CLEAR_OKCODE OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE clear_okcode OUTPUT.
  CLEAR: ok_code.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module SET_ICON OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE set_icon OUTPUT.
  CALL FUNCTION 'ICON_CREATE' "어떤 아이콘을 받아올지 지정해주는 function
    EXPORTING
      name                  = icon_incomplete "ICON TABLE에서 받아올 아이콘의 이름을 지정
      text                  = 'INCOMPLETE' "ICON 옆에 나타내줄 글씨를 입력해줌
    IMPORTING
      result                = st_icon1 "받아온 아이콘은 ST_ICON1에 넣겠다.
    EXCEPTIONS
      icon_not_found        = 1
      outputfield_too_short = 2
      OTHERS                = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  CALL FUNCTION 'ICON_CREATE' "ST_ICON2의 아이콘을 지정해주는 FUNCTION MODULE
    EXPORTING
      name   = icon_total_up
      text   = 'TOTAL'
*     INFO   = ' '
*     ADD_STDINF                  = 'X'
    IMPORTING
      result = st_icon2
* EXCEPTIONS
*     ICON_NOT_FOUND              = 1
*     OUTPUTFIELD_TOO_SHORT       = 2
*     OTHERS = 3
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


ENDMODULE.
