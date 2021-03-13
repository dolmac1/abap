*&---------------------------------------------------------------------*
*& Report ZFLIE_OPEN_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZFLIE_OPEN_PRG_05.

PARAMETERS : pa_fnm TYPE char128.

data: lt_file TYPE filetable, "method에 사용할 변수들
      ls_file like LINE OF lt_file,
      lv_rc TYPE i.

at SELECTION-SCREEN on value-REQUEST FOR pa_fnm. "parameters 받아오는 뒤에 버튼하나 생김
CALL METHOD cl_gui_frontend_services=>file_open_dialog "pattern 에 abap object patterns로 불러옴(value request 버튼을 누르면 실행)
  CHANGING
    file_table              = lt_file "열기창에서 선택한 값을 테이블에 넣어줌(파일의 경로)
    rc                      = lv_rc
*    user_action             =
*    file_encoding           =
  EXCEPTIONS
    file_open_dialog_failed = 1
    cntl_error              = 2
    error_no_gui            = 3
    not_supported_by_gui    = 4
    others                  = 5
        .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

read table lt_file into ls_file index 1. "받아온 경로 중 첫번째 값의 filename을 pa_fnm에 넣어줌
pa_fnm = ls_file-filename.
