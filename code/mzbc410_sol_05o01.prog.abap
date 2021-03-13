*----------------------------------------------------------------------*
***INCLUDE MBC410ADIAS_DYNPROO01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  move_to_dynp  OUTPUT
*&---------------------------------------------------------------------*
*       copy data to screen structure
*----------------------------------------------------------------------*
MODULE move_to_dynp OUTPUT.
  MOVE-CORRESPONDING wa_sflight TO sdyn_conn.
ENDMODULE.                 " move_to_dynp  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  status_0100  OUTPUT
*&---------------------------------------------------------------------*
*       set status and title for screen 100
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  IF MAINTAIN_FLIGHTS = 'X'. "radio button이 maintain flights이면
    SET PF-STATUS 'STATUS_100'. "save 버튼도 가능하도록
  ELSE.
    SET PF-STATUS 'STATUS_100' EXCLUDING 'SAVE'. "나머지 경우에는 save버튼 안됨
  ENDIF.

  CASE 'X'. "radio button이
    WHEN view. "view일때 제목
      SET TITLEBAR 'TITLE_100' WITH 'Anzeige'(vie).
    WHEN maintain_flights. "maintain flights일때 제목
      SET TITLEBAR 'TITLE_100' WITH 'Flug pflegen'(fli).
    WHEN maintain_bookings."maintain bookings일때 제목
      SET TITLEBAR 'TITLE_100' WITH 'Maintain Bookings'(boo).
  ENDCASE.

ENDMODULE.                 " status_0100  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  status_0150  OUTPUT
*&---------------------------------------------------------------------*
*       set status and title for screen 150
*----------------------------------------------------------------------*
MODULE status_0150 OUTPUT.
  SET PF-STATUS 'STATUS_150'.
  SET TITLEBAR  'TITLE_150' WITH text-vie.
ENDMODULE.                 " status_0150  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  clear_ok_code  OUTPUT
*&---------------------------------------------------------------------*
*       initialize ok_code
*----------------------------------------------------------------------*
MODULE clear_ok_code OUTPUT.
  CLEAR ok_code.
ENDMODULE.                 " clear_ok_code  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  modify_screen  OUTPUT
*&---------------------------------------------------------------------*
*       change elements dynamically
*----------------------------------------------------------------------*
MODULE modify_screen OUTPUT.
IF MAINTAIN_FLIGHTS = 'X'. "radio button이 maintain flights이면
    LOOP AT SCREEN.
      IF SCREEN-NAME = 'SDYN_CONN-PLANETYPE'. "screen의 이름이 sdyn_conn-planetype인
        SCREEN-INPUT = 1. "부분의 입력을 가능하도록 함
        MODIFY SCREEN. "스크린에 적용
      ENDIF.
    ENDLOOP.
  ENDIF.

ENDMODULE.                 " modify_screen  OUTPUT
*&---------------------------------------------------------------------*
*& Module FILL_DYNNR OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE fill_dynnr OUTPUT.
 CASE 'X'. "radio button이
    WHEN view. "view이면 110번 서브 스크린
      dynnr = '0110'.
    WHEN maintain_flights. "maintain flights 이면 120번 스크린
      dynnr = '0120'.
    WHEN maintain_bookings. "maintain bookings이면 130번 스크린으로 지정
      dynnr = '0130'.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module GET_SPFLI OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE get_spfli OUTPUT. "110번 스크린의 필드들의 값을 받아오는 모듈
  select single * from spfli into CORRESPONDING FIELDS OF sdyn_conn
    where carrid = sdyn_conn-carrid
    and connid = sdyn_conn-connid.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module GET_SAPLANE OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE get_saplane OUTPUT. "120번 스크린의 필드들의 값을 받아오는 모듈
    select single * from saplane
       where planetype = sdyn_conn-planetype.
ENDMODULE.
