*&---------------------------------------------------------------------*
*& Report ZBC400_05_COMPUTE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC400_05_COMPUTE MESSAGE-ID ZMSG_CLASS_05.

PARAMETERS: pa_int1 type i,
            pa_int2 TYPE i,
            pa_op TYPE c.

data: gv_result type p length 16 DECIMALS 2.
*IF pa_op = '+' or pa_op = '-' or pa_op = '/' or pa_op = '*'.
*  IF pa_int2 = 0 and pa_op = '/'.
*
*    message i000(zmsg_class_05).
**패키지 우클릭 create - other(1) - massage class
*   else.
*     CASE pa_op.
*       WHEN '+'.
*        gv_result = pa_int1 + pa_int2.
*       WHEN '-'.
*        gv_result = pa_int1 - pa_int2.
*       WHEN '*'.
*        gv_result = pa_int1 * pa_int2.
*       WHEN '/'.
*         gv_result = pa_int1 / pa_int2.
*      ENDCASE.
*      write : 'gv_result : ', gv_result.
*  ENDIF.
*  else.
**    message s001(zmsg_class_05) with pa_op sy-uname sy-langu sy-uzeit.
** message 설정할때 with 뒤에 들어갈 것 들어갈 위치를 & 로 지정해줌
*    message s001 with pa_op sy-uname sy-langu sy-uzeit.
**    맨위에 MESSAGE-ID 를 인클루드 해주면 (zmsg_class_05)생략가능
**     MESSAGE 'invalid operator!' TYPE 'I'.
*ENDIF.
call function 'ZCALC_05'
  exporting
    iv_int1 = pa_int1
    iv_int2 = pa_int2
    iv_op   = pa_op
 IMPORTING
   EV_RESULT       = gv_result
  .
write:/ pa_int1, pa_op, pa_int2, '=',gv_result.
