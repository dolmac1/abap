*&---------------------------------------------------------------------*
*& Include          ZALV_FCAT_PRG_05C01
*&---------------------------------------------------------------------*

CLASS lcl_event_handler DEFINITION. "이벤트 처리를 위한 클래스 정의
  PUBLIC SECTION.
    CLASS-METHODS: on_double_click FOR EVENT double_click "더블클릭에 관한 이벤트 처리(static method)
                  OF cl_gui_alv_grid "CL_GUI_ALV_GRID에서(우리가 하고있는 ALV) 발생하는 이벤트이며
      IMPORTING es_row_no e_column, "row 정보와 column정보를 받아와서 처리
      on_hotspot_click FOR EVENT hotspot_click "HOTSPOT 이 클릭되는 이벤트가 발생되면
                    OF cl_gui_alv_grid "ALV에서
        IMPORTING es_row_no e_column_id, "줄번호와 필드이름을 임포트 시켜줘서 실행
      on_toolbar FOR EVENT toolbar OF cl_gui_alv_grid "툴바에 이벤트가 발생하면 실행
        IMPORTING e_object, "e_object를 포함
      on_user_command FOR EVENT user_command OF cl_gui_alv_grid
        IMPORTING e_ucomm.
ENDCLASS.

CLASS lcl_event_handler IMPLEMENTATION. "이벤트 처리를 위한 클래스 구현
  METHOD on_double_click. "on_double_click에 대한 처리를 정의
    IF e_column-fieldname = 'AGENCYNUM'. "필드명이 AGENCYNUM 이면
      READ TABLE gt_data INTO gs_data INDEX es_row_no-row_id. "읽어온 줄의 데이터를 받아옴
      SELECT SINGLE * FROM stravelag "STRAVELAG 테이블에서 1개의 데이터를 받아오는데
        INTO CORRESPONDING FIELDS OF stravelag "STRAVELAG로 다시 받아올 것이고
        WHERE agencynum = gs_data-agencynum. "조건은 AGENCYNUM이 GS_DATA의 AGENCYNUM과 같은 것이다.
      CALL SCREEN 120 "스크린 호출
      STARTING AT 10 5
      ENDING AT 60 20.
    ELSE. "필드명이 AGENCYNUM이 아닐때는
      MESSAGE i016(bc405_408) WITH es_row_no-row_id e_column-fieldname. "메시지를 줄번호와 필드이름을 포함하여 i타입으로 출력해줌
    ENDIF.

  ENDMETHOD.
  METHOD on_hotspot_click.
*    MESSAGE i016(bc405_408) WITH es_row_no-row_id e_column_id-fieldname.
    READ TABLE gt_data INTO gs_data INDEX es_row_no-row_id. "GT_DATA INTERNAL TABLE에서 GS_DATA로 가져오는데 INDEX가 클릭된 곳을 받아옴
    SELECT SINGLE * "SCUSTOM에서 ID 가 GS_DATA의 CUSTOMID와 같은 것을 하나 골라서 받아옴
      FROM scustom
      INTO CORRESPONDING FIELDS OF scustom
      WHERE id = gs_data-customid.
    "SCUSTOM에 값을 찾아서 넣어줌 "110번 스크린의 PBO에서 해줘도 됨
    CALL SCREEN 110 STARTING AT 10 5 ENDING AT 60 10.
    " 스크린을 띄워줌
  ENDMETHOD.

  METHOD on_toolbar.
    DATA: ls_button TYPE stb_button.

    ls_button-butn_type = 3. "function사이에 선하나를 삽입함(구분자)
    APPEND ls_button TO e_object->mt_toolbar.
    CLEAR: ls_button.

    ls_button-function = 'FC1'. "function의 이름
    ls_button-icon = icon_failure. "아이콘 모양
    ls_button-butn_type = 0. "버튼의 형태는 0번(normal)
*    ls_button-disabled = 'X'. "버튼이 클릭 될지 말지
    ls_button-checked = 'X'. "클릭되어있는 것처럼 보여지게함
    APPEND ls_button TO e_object->mt_toolbar.
  ENDMETHOD.
  method on_user_command.
    case E_UCOMM.
      WHEN 'FC1'.
        MESSAGE 'Customer Function' TYPE 'I'.
      ENDCASE.
  endmethod.
ENDCLASS.
