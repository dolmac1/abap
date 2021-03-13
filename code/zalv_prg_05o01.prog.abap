*&---------------------------------------------------------------------*
*& Include          ZALV_PRG_05O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
 SET PF-STATUS 'S100'.
 SET TITLEBAR 'T100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CLEAR_OKCODE OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE clear_okcode OUTPUT.
 CLEAR: OK_CODE. "동작 할때마다 OK_CODE CLEAR시킴
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_ALV OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_alv OUTPUT. "AREA에 CONTAINER연결하고 CONTAINER에 ALV GRID 연결한 후 ALV에 데이터를 출력하는 모듈
  IF GO_CON IS INITIAL. "GO_CON이 참조하고 있는 것이 없으면
    "OBECT 생성
    CREATE OBJECT go_con "PATTERN으로 불러옴
      EXPORTING "
        container_name              = 'AREA' "100번 스크린의 AREA에 CONTAINER 연결
      EXCEPTIONS "에러처리
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
    CREATE OBJECT go_alv "PATTERN 으로 불러옴
      EXPORTING
        i_parent          = GO_CON "CONTAINER 에 ALV GRID연결
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

    PERFORM SET_VARIANT. "VARIANT의 값을 지정해주는 FORM
    PERFORM SET_LAYOUT. "LAYOUT의 값을 지정해주는 FORM
    PERFORM SET_SORT. "SORT의 값을 지정해주는 FORM
    PERFORM SET_TOOLBAR. "TOOL 바에 대한 설정 지정
    CALL METHOD go_alv->set_table_for_first_display "ALV에 TABLE을 DISPLAY하기위한 메소드
      EXPORTING
        i_structure_name              = 'SFLIGHT' "정보를 가져오는 STRUCTURE의 모양(이걸 다른 디비 테이블로 지정하면 이상하게 나옴)
        IS_VARIANT                    = GS_VARIANT "어떤 VARIANT를 쓸 것인지 지정
        I_SAVE                        = 'A' "모든 유저가 저장 가능
        IS_LAYOUT                      = GS_LAYOUT "LAYOUT을 설정해줌
        IT_TOOLBAR_EXCLUDING          = GT_FUNC "TOOL 바에 대한 설정 지정
      CHANGING
        it_outtab                     = GT_DATA "데이터베이스에서 DATA를 가져온 INTERNAL TABLE
        it_sort                       = GT_SORT "정렬 조건을 넣어줌
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
