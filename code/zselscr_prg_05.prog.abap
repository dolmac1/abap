*&---------------------------------------------------------------------*
*& Report ZSELSCR_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSELSCR_PRG_05. "selection screen 만들고 블락쳐서 나누는 방법

data: gs_flight TYPE bc400_s_flight.

SELECTION-SCREEN begin of BLOCK block1 with FRAME.
  select-options : so_car for gs_flight-carrid no-EXTENSION, "multi selection 버튼이 없는 select option을 만듬
                   so_con for gs_flight-connid no INTERVALS, "to+input option이 들어갈 칸을 만들지 않는 select option
                   so_fdt for gs_flight-fldate no-EXTENSION NO INTERVALS. "위의 두가지를 다 없앤 경우의 select option
SELECTION-SCREEN END OF BLOCK block1.
selection-SCREEN BEGIN OF BLOCK block2 WITH FRAME TITLE text-t01. "t01을 더블클릭하면 text symbols를 설정가능
  SELECTION-SCREEN BEGIN OF LINE. "한줄짜리 SELECTION-SCREEN(이것 쓰면 END까지의 내용이 한줄로 나옴)
    SELECTION-SCREEN COMMENT 1(20) TEXT-c01. "1번째 컬럼에 20자리의 text를 쓰겠다(c01 더블클릭해서 text symbols 지정)
    SELECTION-SCREEN COMMENT 25(10) TEXT-c02 for FIELD pa_all. "25번째 컬럼에 10자리 FOR FIELD를 쓰면 누를시 체크박스 눌러짐
    PARAMETERS: pa_all AS CHECKBOX. "체크박스 만들기
    SELECTION-SCREEN COMMENT 45(10) TEXT-c03. "45번째 컬럼에 10자리 COMMENT의 위치는 겹칠시 에러남
    PARAMETERS: pa_int as CHECKBOX."체크박스 만들기
    SELECTION-SCREEN COMMENT 65(10) TEXT-c04.
    PARAMETERS: pa_nat AS CHECKBOX."체크박스 만들기
  SELECTION-SCREEN END OF LINE.


  PARAMETERS: "pa_all as CHECKBOX DEFAULT 'X', "pa_all을 체크박스로 선언(체크된 상태로)
              "pa_int as CHECKBOX, "pa_int을 체크박스로 선언
              "pa_nat as CHECKBOX, "pa_nat을 체크박스로 선언
              pa_lim_1 RADIOBUTTON GROUP rb1 DEFAULT 'X',
              pa_lim_2 RADIOBUTTON GROUP rb1,
              pa_lim_3 RADIOBUTTON GROUP rb1.
              "rb1 그룹에 pa_lim_1,2,3 3개의 버튼이 있는 라디오 버튼을 만듬
              "여기서 라디오버튼의 그룹이 같으면 그중 하나만 선택 가능(선택지 고를 때 이걸 이용하면 됨) - default가 하나만 가능
SELECTION-SCREEN END OF BLOCK block2.

*INITIALIZATION.
*pa_int = 'X'. "이런 방식으로 CHECK 박스에 체크가 되도록 설정 가능(단, DEFAULT가 설정이 아무데도 안되어있을때만 가능)
*pa_lim_3 = 'X'. "이런 방식으로 라디오 버튼에 체크 위치 지정 가능(단, DEFAULT가 설정이 아무데도 안되어있을때만 가능)
