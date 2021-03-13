*&---------------------------------------------------------------------*
*& Include          MZBC410_SOLI01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  CHECK_SFLIGHT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_sflight INPUT.
 SELECT SINGLE *
    INTO CORRESPONDING FIELDS OF SDYN_CONN
    FROM SFLIGHT
    WHERE CARRID = SDYN_CONN-CARRID
      AND CONNID = SDYN_CONN-CONNID
      AND FLDATE = SDYN_CONN-FLDATE.
      IF sy-subrc <> 0.
        CLEAR wa_sflight.
      ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE io_command.
    WHEN 'X'.
      LEAVE TO SCREEN 0.
   ENDCASE.
ENDMODULE.
