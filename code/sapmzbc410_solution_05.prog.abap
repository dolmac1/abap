*&---------------------------------------------------------------------*
*& Module Pool      SAPMZBC410_SOLUTION_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE MZBC410_SOLUTIO_05TOP.
INCLUDE MZBC410_SOLUTIO_05O01.
INCLUDE MZBC410_SOLUTIO_05I01.
*&---------------------------------------------------------------------*
*& Form SET_MODE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_mode .
  IF GV_MODE = 'D'. "DISPLAY 모드이면
        GV_MODE = 'C'. "CHANGE모드로
      ELSE. "CHANGE모드면
        GV_MODE = 'D'. "DISPLAY모드로 바꿔줌
      ENDIF.
ENDFORM.
