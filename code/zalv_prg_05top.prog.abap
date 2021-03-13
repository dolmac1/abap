*&---------------------------------------------------------------------*
*& Include          ZALV_PRG_05TOP
*&---------------------------------------------------------------------*

*data: gt_data TYPE TABLE OF sflight, "데이터베이스에서 데이터를 받아올 테이블
*      gs_data like LINE OF gt_data.

DATA: BEGIN OF gs_data. "GS_DATA라는 스트럭쳐를 만드는데
    INCLUDE TYPE sflight. "SFLIGHT의 모든 필드를 포함시키고
DATA: light TYPE c, "C TYPE으로 선언된 LIGHT 변수도 포함시킨다.
      color TYPE char4, "필드의 색깔을 지정해주는 변수
      itcol TYPE lvc_t_scol, "셀마다 색깔 지정할 수 있게 해주는 딥 스트럭쳐로 만들어주는 테이블
      END OF gs_data, "여기까지가 GS_DATA 스트럭쳐 선언부
      gt_data LIKE TABLE OF gs_data. "위에서 선언한 GS_DATA를 통해서 GT_DATA라는 INTERNAL TABLE 선언(DB에서 데이터를 받아올 테이블임)
DATA : GT_SORT TYPE LVC_T_SORT. "SORTING에 사용할 테이블(여러개를 한번에 SORTING 할 수 있음)
DATA: ok_code TYPE sy-ucomm.

DATA: go_con TYPE REF TO cl_gui_custom_container, "AREA에 올릴 CONTAINER를 올리기 위해서 생성해줌(참조변수)
      go_alv TYPE REF TO cl_gui_alv_grid. "CONTAINER CONTROL에 올릴 ALV를 올리기 위해서 생성(참조변수)
DATA: gs_variant TYPE disvariant. "VARIANT를 저장할 변수
DATA: gs_layout TYPE lvc_s_layo. "LAYOUT을 지정해주기위한 스트럭쳐
DATA: GT_FUNC TYPE UI_FUNCTIONS. "툴바에 대한 설정을 지정해줄 변수 테이블 선언
SELECTION-SCREEN BEGIN OF BLOCK blk1 WITH FRAME. "셀렉션 스크린에서 프레임(틀)을 가지고 있는 BLOCK 하나 생성
SELECT-OPTIONS: so_car FOR gs_data-carrid, "SELECT OPTION으로 CARRID와 CONNID 의 조건을 받아옴
               so_con FOR gs_data-connid.
SELECTION-SCREEN END OF BLOCK blk1.
