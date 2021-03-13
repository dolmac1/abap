*&---------------------------------------------------------------------*
*& Include          ZALV_PRG_05F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form GET_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .
  SELECT * INTO CORRESPONDING FIELDS OF TABLE GT_DATA "SFLIGHT에서 GT_DATA로 조건에 맞는 값들 받아옴
    FROM SFLIGHT
    WHERE CARRID IN SO_CAR
    AND CONNID IN SO_CON.
    data: ls_col type lvc_s_scol. "각 셀에 색을 지정해주는 딥 스트럭쳐안의 테이블(gt_data-itcol)에 설정값을 넣어주기 위한 스트럭쳐 생성
    LOOP AT GT_DATA INTO GS_DATA.
      IF GS_DATA-SEATSOCC < 50. "남은 자리가 50자리 이하면
        GS_DATA-LIGHT = 1. "LIGHT 에 1을 넣어줌
      ELSEIF GS_DATA-SEATSOCC < 150. "50이상 150이하이면
        GS_DATA-LIGHT = 2. "LIGHT에 2를 넣어줌
      ELSE. "나머지는
        GS_DATA-LIGHT = 3. "3을 넣어줌
      ENDIF.
      IF gs_data-seatsocc_f = 0.
        gs_data-color = 'C' && '6' && '1' && '0'. "6번 색깔(빨간색)을 넣어줌, INTENSIFIED = 1, INVERSE = 0.
        " gs_data-color = 'C610'도 가능, 빨간색을 글자색으로 하고싶으면 C601
      ENDIF.
      IF gs_data-seatsocc = 0. "만약 남은 좌석이 0자리이면
        ls_col-FNAME = 'SEATSOCC'. "SEATSOCC 필드의 값에(대문자로 안쓰면 안된다)
        ls_col-COLOR-col = COL_TOTAL. "3번색깔을 넣어주고
        ls_col-color-int = '1'. "INTENSIFIED(진하게할지)는 1로
        ls_col-color-inv = '0'. "INVERSE(글씨색으로 할지)는 0으로 지정
        APPEND ls_col to GS_DATA-ITCOL.
      ENDIF.
      IF gs_data-planetype = '747-400'. "만약 비행기 타입이 747-400이면
        ls_col-FNAME = 'PLANETYPE'. "PLANETYPE 필드의 값에
        ls_col-COLOR-col = COL_GROUP. "7번색깔 지정
        ls_col-color-int = '1'. "INTENSIFIED(진하게할지)는 1로
        ls_col-color-inv = '0'. "INVERSE(글씨색으로 할지)는 0으로 지정
        APPEND ls_col to GS_DATA-ITCOL.
      ENDIF.
      MODIFY GT_DATA FROM GS_DATA.
    ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_VARIANT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_variant . "VARIANT안의 값을 채워줌
  GS_VARIANT-report = SY-CPROG.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_LAYOUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_layout .
  GS_LAYOUT-GRID_TITLE = 'ALV GRID TITLE'. "ALV GRID의 TITLE 설정
  GS_LAYOUT-ZEBRA = 'X'. "무늬 설정(줄마다 색깔이 번갈아서 나옴)
  GS_LAYOUT-cwidth_opt = 'X'. "너비가 자동으로 조정되게 설정
*  GS_LAYOUT-NO_TOOLBAR = 'X'. "툴바를 안보이게 설정해줌
*  GS_LAYOUT-NO_HEADERS = 'X'. "HEADER를 안보이게 설정해줌
  GS_LAYOUT-sel_mode = 'A'. "COLUMN과 ROW를 어떤 형태로 누르게 해줄것인가 A,B,C,D가능
  GS_LAYOUT-EXCP_FNAME = 'LIGHT'. "추가로 넣어줄 EXCEPTION 필드의 이름을 입력(신호등)
  GS_LAYOUT-info_fname = 'COLOR'. "색깔 지정한 것을 적용하겠다.
  GS_LAYOUT-ctab_fname = 'ITCOL'. "텝마다 지정하는 색깔을 어떤 필드로 넣을 것인가
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_SORT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_sort .
  DATA: LS_SORT TYPE LVC_S_SORT. "SORT를 어떻게 할 것인지 한줄씩 넣어야하므로 선언

  LS_SORT-FIELDNAME = 'CARRID'. "필드 이름이 CARRID 인 필드에 의해서
  APPEND LS_SORT TO GT_SORT. "기본값(오름차순)으로 정렬
  CLEAR: LS_SORT.
  LS_SORT-FIELDNAME = 'FLDATE'. "FLDATE 필드에 의해서는
  LS_SORT-DOWN = 'X'. "내림차순으로 정렬
  APPEND LS_SORT TO GT_SORT.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_TOOLBAR
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_toolbar .
  APPEND CL_GUI_ALV_GRID=>MC_FC_FILTER to GT_FUNC. "툴바의 필터를 안보이게 설정
  APPEND CL_GUI_ALV_GRID=>MC_MB_SUM to GT_FUNC. "툴바의 SUM을 안보이게 설정
  APPEND CL_GUI_ALV_GRID=>MC_FC_DETAIL to GT_FUNC. "돋보기 모양 아이콘 안보이게 설정
ENDFORM.
