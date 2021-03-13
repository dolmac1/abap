*----------------------------------------------------------------------*
***INCLUDE MBC410ADIAS_DYNPROI01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  check_sflight  INPUT
*&---------------------------------------------------------------------*
*       Read flight record from database
*----------------------------------------------------------------------*

MODULE check_sflight INPUT.
  SELECT SINGLE * "입력한 조건에 대해서 wa_sflight로 값을 받아옴(나중에 sdyn_conn으로 넣어서 100번 화면에 출력)
    FROM sflight
* INTO CORRESPONDING FIELDS OF sdyn_conn 	" direct read
    INTO wa_sflight         " Read into internal structure
    WHERE carrid = sdyn_conn-carrid AND
          connid = sdyn_conn-connid AND
          fldate = sdyn_conn-fldate.
  CHECK sy-subrc <> 0.
  CLEAR wa_sflight.
  MESSAGE e007(bc410).

ENDMODULE.                 " check_sflight  INPUT
*&---------------------------------------------------------------------*
*&      Module  user_command_0100  INPUT
*&---------------------------------------------------------------------*
*       process user command
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'BACK'. "back버튼 누르면 이전화면으로
      LEAVE TO SCREEN 0.
* display time on add'l screen
    WHEN 'TIME'. "time버튼 누르면 시간 창(150번 스크린) 출력
      CALL SCREEN 150
        STARTING AT 10 10
        ENDING   AT 50 20.
    WHEN 'FC1' OR 'FC2' OR 'FC3'.
      my_tabstrip-activetab = ok_code.
  ENDCASE.
ENDMODULE.                 " user_command_0100  INPUT
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
  CASE OK_CODE.
    WHEN 'EXIT'. "exit 버튼을 누르면 프로그램 종료
      LEAVE PROGRAM.
    WHEN 'CANC'. "CANCEL 버튼을 눌렀을 경우에는
      CLEAR: WA_SFLIGHT. "WA_SFLIGHT를 CLEAR해주고
      SET PARAMETER ID: "SAP 메모리에 들어간 값들을 초기화 시켜줘서 다시 입력받도록함. 이걸 안하면 output 부분들만 초기화되서 사라짐
        'CAR' FIELD WA_SFLIGHT-CARRID,
        'CON' FIELD WA_SFLIGHT-CONNID,
        'DAY' FIELD WA_SFLIGHT-FLDATE.
      LEAVE TO SCREEN 100. "초기화 된 값을 적용해서 100번 스크린을 보여줌(이것 안쓰면 값만 지우고 화면은 변경 안해줌)
    WHEN OTHERS.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CHECK_PLANETYPE  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_planetype INPUT.
  IF sdyn_conn-planetype is INITIAL. "만약 planetype이 비어있으면
    message e555(bc410) with 'plane type needed'(plt). "planetype이 필요하다고 에러메시지
  ENDIF.
  select SINGLE seatsmax into sdyn_conn-seatsmax from saplane "에러가 발생하지 않았다면 saplane에서 seatsmax를 받아옴
    where planetype = sdyn_conn-planetype.
  IF sdyn_conn-seatsocc > sdyn_conn-seatsmax. "만약 총 좌석수보다 남은 수가 많으면 오류니까
    MESSAGE E109(BC410). "에러 메시지 출력
  ELSE.
    MOVE-CORRESPONDING SDYN_CONN TO WA_SFLIGHT. "그렇지 않을 경우에는 값을WA_SFLIGHT에 넣어줌
  ENDIF.

ENDMODULE.
