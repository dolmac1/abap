*&---------------------------------------------------------------------*
*& Report  BC402_PCt_CONN_LIST
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zbc402_05_conn_list MESSAGE-ID bc402.

TYPES: BEGIN OF gty_s_conn,
        carrid TYPE spfli-carrid,
        connid TYPE spfli-connid,
        cityfrom TYPE spfli-cityfrom,
        cityto TYPE spfli-cityto,
        deptime TYPE spfli-deptime,
        arrtime TYPE spfli-arrtime,
        period TYPE spfli-period,
      END OF gty_s_conn.

TYPES gty_t_conn TYPE STANDARD TABLE OF gty_s_conn
                 WITH NON-UNIQUE DEFAULT KEY.

DATA gt_conn TYPE gty_t_conn.

DATA gv_msg TYPE string.

DATA: go_alv TYPE REF TO cl_salv_table,
      go_evt TYPE REF TO cl_salv_events_table,
      gx_msg TYPE REF TO cx_salv_msg.

*----------------------------------------------------------------------*
*       CLASS lcl_handler DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_handler DEFINITION.

  PUBLIC SECTION.

    CLASS-METHODS:
          on_double_click FOR EVENT double_click
                                 OF if_salv_events_actions_table
                          IMPORTING row column.

ENDCLASS.                    "lcl_handler DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_handler IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_handler IMPLEMENTATION.

  METHOD on_double_click.

    DATA ls_conn LIKE LINE OF gt_conn.

    READ TABLE gt_conn INTO ls_conn INDEX row.

    CASE column.

      WHEN 'CARRID'.

      WHEN OTHERS.
        SUBMIT BC402_INS_FLIGHT_LIST_OSQL "carrid 필드를 클릭하면 bc402_ins_flight_list_osql 프로그램을 호출하는데
        AND RETURN "끝나면 여기로 돌아올 것이고
        WITH pa_car = ls_conn-carrid "호출된 프로그램의 pa_car은 현재 프로그램의 ls_conn-carrid로
        WITH so_con = ls_conn-connid. "pa_con은 ls_conn-connid로 한다.
    ENDCASE.

  ENDMETHOD.                    "on_double_click

ENDCLASS.                    "lcl_handler IMPLEMENTATION


START-OF-SELECTION.

  SELECT carrid connid cityfrom cityto
         deptime arrtime period
    FROM spfli
    INTO TABLE gt_conn.

  TRY.
      CALL METHOD cl_salv_table=>factory
        IMPORTING
          r_salv_table = go_alv
        CHANGING
          t_table      = gt_conn.
    CATCH cx_salv_msg INTO gx_msg.
      gv_msg = gx_msg->get_text( ).
      MESSAGE gv_msg TYPE 'E'.
  ENDTRY.

  go_evt = go_alv->get_event( ).

  SET HANDLER lcl_handler=>on_double_click
          FOR go_evt.

  go_alv->display( ).
