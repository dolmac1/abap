*&---------------------------------------------------------------------*
*& Include          ZALV_FCAT_PRG_05F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form GET_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data . "데이터 받아오는 서브 프로그램
  SELECT * INTO CORRESPONDING FIELDS OF TABLE gt_data "GT_DATA테이블에 SBOOK DATABASE에서 데이터를 받아옴
    FROM sbook
    WHERE carrid IN so_car
    AND connid IN so_con.

  LOOP AT GT_DATA INTO GS_DATA. "받아온 값에대한 반복문
    IF GS_DATA-CANCELLED = 'X'. "만약 취소되었다고 되있는 경우에는
      GS_DATA-cicon = ICON_INCOMPLETE. "X모양 아이콘을 넣어줌

    ENDIF.
    select single telephone into gs_data-phone from scustom where id = gs_data-customid. "전화번호 넣는 select 문
    MODIFY GT_DATA FROM GS_DATA. "GT_DATA에 다시 넣어줌
  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_FCAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_fcat.
  DATA: LS_FCAT TYPE LVC_S_FCAT. "FIELD CATALOG를 처리해줄 스트럭쳐
  ls_fcat-fieldname = 'PHONE'. "PHONE 필드는
  ls_fcat-ref_table = 'SCUSTOM'. "SCUSTOM의
  ls_fcat-ref_field = 'TELEPHONE'. "TELEPHONE필드를 참조하여
  ls_fcat-col_pos = 4. "4번째 column에 가져다 두겠다.
  append ls_fcat to gt_fcat.

  clear: ls_fcat.
  ls_fcat-FIELDNAME = 'CICON'. "CICON 필드는
  ls_fcat-ICON = 'X'. "아이콘으로 출력하며
  ls_fcat-coltext = 'Cancelled'. "COLUMN의 이름은 Cancelled로 해줌
  append ls_fcat to gt_fcat.
  clear: ls_fcat.

  ls_fcat-FIELDNAME = 'CANCELLED'. "필드명이 cancelled인 필드는
  ls_fcat-no_out = 'X'. "화면에 출력 x
  append ls_fcat to gt_fcat.
  clear: ls_fcat.

  ls_fcat-fieldname = 'CUSTOMID'. "필드명이 CUSTOMID인 필드의 값을 클릭하면
  ls_fcat-hotspot = 'X'. "hotspot 이벤트가 발생하도록 함
  APPEND ls_fcat to gt_fcat.
  clear: ls_fcat.


ENDFORM.
