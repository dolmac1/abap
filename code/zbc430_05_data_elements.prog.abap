*&---------------------------------------------------------------------*
*& Report ZBC430_05_DATA_ELEMENTS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC430_05_DATA_ELEMENTS.

PARAMETERS: pa_fname TYPE zfirstname05, "zdo_30char_05로 구현한 data element(타입)으로 first name을 입력받을 변수 선언
            pa_lname TYPE zlastname05, "zdo_30char_05로 구현한 data element(타입)으로 last name을 입력받을 변수 선언
            pa_activ TYPE zassets05, "zdo_10num_05로 구현한 data element(타입)으로 assets을 입력받을 변수 선언
            pa_liabs TYPE zliabilities05. "zdo_10num_05로 구현한 data element(타입)으로 liability를 입력받을 변수 선언

data: gv_result TYPE zassets05. "자산 상태(assets - liability)를 구하기위한 변수

gv_result = pa_activ - pa_liabs. "자산상태 계산

START-OF-SELECTION.

NEW-LINE.
  WRITE: 'Client:', pa_fname, pa_lname.

  gv_result = pa_activ - pa_liabs.

  NEW-LINE.
  WRITE: 'Finance:', pa_activ, pa_liabs, gv_result.
