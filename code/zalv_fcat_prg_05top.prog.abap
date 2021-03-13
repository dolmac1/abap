*&---------------------------------------------------------------------*
*& Include          ZALV_FCAT_PRG_05TOP
*&---------------------------------------------------------------------*

TABLES: SCUSTOM,
        STRAVELAG.

DATA: BEGIN OF gs_data. "gs_data를 스트럭쳐로 만드는데
    INCLUDE TYPE sbook. "sbook의 모든 필드를 포함하고
DATA: phone TYPE scustom-telephone, "phone 필드 (전화번호를 집어넣을 필드)
      cicon TYPE icon-id, "cicon 필드를 함께 포함해서(cancel했는지 아이콘을 집어 넣을 필드)
      END OF gs_data, "만듬
      gt_data LIKE TABLE OF gs_data. "gs_data를 통해서 gt_data 테이블을 만듬

data : gt_fcat type lvc_t_fcat. "FIELD의 카탈로그를 정의해줄 변수



data: go_con TYPE REF TO cl_gui_custom_container, "container를 area에 연결하기 위한 참조변수
      go_alv TYPE REF TO cl_gui_alv_grid. "alv를 container에 연결하기 위한 참조변수

data: ok_code TYPE sy-ucomm. "버튼에 대한 처리를 해줄 변수

SELECT-OPTIONS: so_car FOR gs_data-carrid DEFAULT 'AA', "selection screen 에서 처리할 내용들
so_con FOR gs_data-connid.

START-OF-SELECTION. "시작
PERFORM GET_DATA. "데이터를 받아올 서브 프로그램

IF GT_DATA IS NOT INITIAL. "만약 GT_DATA에 데이터가 있으면
  CALL SCREEN 100."100번 스크린을 불러옴
ENDIF.
