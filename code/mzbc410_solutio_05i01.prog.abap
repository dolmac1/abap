*&---------------------------------------------------------------------*
*& Include          MZBC410_SOLUTION_05I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  CHECK_SFLIGHT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE CHECK_SFLIGHT INPUT. "SFLIGHT에서 데이터베이스 한줄을 받아오는 모듈
  SELECT SINGLE * "데이터를 받아옴
    INTO CORRESPONDING FIELDS OF WA_FLIGHT
*    INTO CORRESPONDING FIELDS OF SDYN_CONN
    FROM SFLIGHT
    WHERE CARRID = SDYN_CONN-CARRID
      AND CONNID = SDYN_CONN-CONNID
      AND FLDATE = SDYN_CONN-FLDATE.

  IF SY-SUBRC <> 0. "에러가 발생하면 처리해줄 것
    CLEAR: WA_FLIGHT.
    MESSAGE i007(bc410).
  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT. "IO_COMMAND입력과 DISCHG버튼의 처리를 해줄 모듈

  CASE IO_COMMAND. "만약 IO_COMMAND에
    WHEN 'X'. "X가 입력되면
      LEAVE TO SCREEN 0. "프로그램 종료
    WHEN 'T'.
      CALL SCREEN 150
      STARTING AT 10 5
      ENDING AT 50 8.
  ENDCASE.
  CASE OK_CODE. "만약 OK_CODE에
    WHEN 'DISCHG'. "DISCHG버튼이 눌렸다는 것이 들어오면
*      IF GV_MODE = 'D'. "DISPLAY 모드이면
*        GV_MODE = 'C'. "CHANGE모드로
*      ELSE. "CHANGE모드면
*        GV_MODE = 'D'. "DISPLAY모드로 바꿔줌
*      ENDIF.
      PERFORM set_mode. "위에 주석처리한 것을 form으로 정의
    when 'DIGBOX'.
      CALL SCREEN 110 "스크린 110번을 불러올 것인데
      STARTING AT 10 5 "10,5에서
      ENDING AT 50 10. "50,10으로 화면의 위치를 지정해줌
    WHEN 'EX'.
      LEAVE TO SCREEN 0.
    when 'BACK'. "BACK 버튼 눌렀을때 (무슨 버튼인지는 PBO에 가서 확인가능)
      LEAVE TO SCREEN 0. "이전 화면으로
*    WHEN 'CANC'. "CANC 버튼 눌렀을때
*      LEAVE TO SCREEN 0. "이전 화면으로
*    WHEN 'EXIT'. "EXIT 버튼 눌렀을때
*      LEAVE PROGRAM. "프로그램 종료
    WHEN 'CRT'. "CREATE 버튼 눌렀을때
     GV_MOD = OK_CODE.
    WHEN 'UPD'. "업데이트 버튼 눌렀을때
      PERFORM set_mode. "누르면 display mode랑 change mode 왔다갔다하게
    when 'BTN_END'. "타임창에서 종료 눌렀을 때
      LEAVE TO SCREEN 0.
    WHEN 'TIME'.
      CALL SCREEN 150
      STARTING AT 10 5
      ENDING AT 50 10.

    WHEN OTHERS.
*      clear: gv_mod. "create하고나면 gv_mod에 계속 값이 들어가있어서 엔터 눌러도 값 안들어오는 것을 방지하기 위함
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0150  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0150 INPUT.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT. "CANC 버튼과 EXIT 버튼은 에러 타입으로 바꿔서 필수 입력에 입력이 없어도 강제 종료가능하도록 만듬
  CASE OK_CODE.
    WHEN 'CANC'. "CANC버튼 누르면
      LEAVE TO SCREEN 0. " 이전화면으로
    WHEN 'EXIT'. "EXIT버튼 누르면
      LEAVE PROGRAM. "프로그램 종료
    WHEN OTHERS.
  ENDCASE.
ENDMODULE.
