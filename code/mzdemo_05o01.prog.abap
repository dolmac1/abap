*&---------------------------------------------------------------------*
*& Include          MZDEMO_05O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module TRANS_DATA OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE trans_data OUTPUT.
  MOVE-CORRESPONDING WA_SPFLI TO SDYN_CONN. "SDYN_CONN에서 받아온 값을 WA_SPFLI와 확인
*  sdyn_conn-carrid = 'LH'. "LH라는 값을 할당해줘서 LAYOUT으로 만든 프로그램에 들어가서 확인해보면 LH가 기본으로 들어가있음

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
 SET PF-STATUS 'S100'. "메뉴바 어플리케이션툴바 등을 관리(S100부분 더블클릭해서 들어가서 관리)
 SET TITLEBAR 'T100'. "프로그램의 이름을 지정(TITLE BAR)
ENDMODULE.
