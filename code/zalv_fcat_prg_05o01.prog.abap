*&---------------------------------------------------------------------*
*& Include          ZALV_FCAT_PRG_05O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
 SET PF-STATUS 'S001'. "STATUS내용 지정
 SET TITLEBAR 'T001'. "타이틀 이름 지정
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CLEAR_OKCODE OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE clear_okcode OUTPUT.
  CLEAR:OK_CODE. "동작끝나고 OK_CODE 클리어해줌
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_ALV OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_alv OUTPUT.
  IF GO_CON IS INITIAL. "만약 컨테이너에 대한 오브젝트가 생성되어있지 않다면(맨 처음에 한번만 하면 되니까)
    CREATE OBJECT go_con "AREA에 CONTAINER를 연결해주는 동작 실행
    "PATTERN - ABAP OBJECT - CREATE OBJECT - INSTANCE : GO_CON, CLASS : CL_GUI_CUSTOM_CONTAINER
      EXPORTING
*        parent                      =
        container_name              = 'AREA' "CONTAINER와 연결할 AREA의 이름을 지정해줌
*        style                       =
*        lifetime                    = lifetime_default
*        repid                       =
*        dynnr                       =
*        no_autodef_progid_dynnr     =
      EXCEPTIONS "에러 발생시 처리
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        others                      = 6
        .
    IF sy-subrc <> 0.
*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
    CREATE OBJECT go_alv "ALV를 CONTAINER에 연결해줌
    "PATTERN - ABAP OBJECT - CREATE OBJECT - INSTANCE : GO_ALV, CLASS : CL_GUI_ALV_GRID
      EXPORTING
*        i_shellstyle      = 0
*        i_lifetime        =
        i_parent          = GO_CON "연결해줄 CONTAINER의 이름 지정
*        i_appl_events     = space
*        i_parentdbg       =
*        i_applogparent    =
*        i_graphicsparent  =
*        i_name            =
*        i_fcat_complete   = SPACE
      EXCEPTIONS "에러처리
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        others            = 5
        .
    IF sy-subrc <> 0.
*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

    PERFORM SET_FCAT. "FIELD CATALOG에 대한 설정

    SET HANDLER lcl_event_handler=>on_double_click for go_alv. "C01에 정의된 CLASS를 GO_ALV ALV에서 발생하는 이벤트에 대한 핸들러로 실행함
    "셀을 더블클릭하면 어떤 필드의 몇번째 줄인지 나옴
    SET HANDLER lcl_event_handler=>on_hotspot_click for go_alv. "hotspot된 곳을 클릭했을때 발생하는 이벤트에 대한 헨들링
    set HANDLER lcl_event_handler=>on_toolbar for go_alv. "툴바에 대한 핸들러 지정
    set HANDLER lcl_event_handler=>on_user_command for go_alv. "user 커멘드에 대한 핸들러 지정(새로만든 버튼 누를시 메시지 띄움)

    CALL METHOD go_alv->set_table_for_first_display "ALV에 출력을 지정해줌
    "PATTERN - ABAP OBJECT - CALL METHOD - INSTANCE : GO_ALV, CLASS : CL_GUI_ALV_GRID, METHOD : SET_TABLE_FOR_FIRST_DISPLAY
      EXPORTING
*        i_buffer_active               =
*        i_bypassing_buffer            =
*        i_consistency_check           =
        i_structure_name              = 'SBOOK' "출력하는 STRUCTURE 타입 지정
*        is_variant                    =
*        i_save                        =
*        i_default                     = 'X'
*        is_layout                     =
*        is_print                      =
*        it_special_groups             =
*        it_toolbar_excluding          =
*        it_hyperlink                  =
*        it_alv_graphics               =
*        it_except_qinfo               =
*        ir_salv_adapter               =
      CHANGING
        it_outtab                     = GT_DATA "DATA를 가지고 있는 INTERNAL TABLE 지정
        it_fieldcatalog               = GT_FCAT "FIELD CATALOG에 대한 정보를 가진 테이블 지정
*        it_sort                       =
*        it_filter                     =
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        others                        = 4
            .
    IF sy-subrc <> 0.
*     Implement suitable error handling here
    ENDIF.


  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0110 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0110 OUTPUT.
 SET PF-STATUS 'S002'.
 SET TITLEBAR 'T002'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module MOVE_DATA OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module GET_CUSTOM_DATA OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE get_custom_data OUTPUT.
*  SELECT SINGLE * FROM scustom INTO CORRESPONDING FIELDS OF scustom WHERE id = gs_data-customid.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0120 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0120 OUTPUT.
 SET PF-STATUS 'S003'.
 SET TITLEBAR 'T003'.
ENDMODULE.
