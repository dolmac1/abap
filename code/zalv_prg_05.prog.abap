*&---------------------------------------------------------------------*
*& Report ZALV_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZALV_PRG_05.
INCLUDE ZALV_PRG_05TOP.
INCLUDE ZALV_PRG_05I01.
INCLUDE ZALV_PRG_05O01.
INCLUDE ZALV_PRG_05F01.

START-OF-SELECTION.
  PERFORM GET_DATA. "GT_DATA로 SFLIGHT에서 값을 받아옴

  IF GT_DATA IS NOT INITIAL. "GT_DATA에 데이터가 있으면
    CALL SCREEN 100. "100번 스크린 실행
  ENDIF.
