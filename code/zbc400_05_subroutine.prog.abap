REPORT ZBC400_05_SUBROUTINE.
TYPES TV_RESULT TYPE P LENGTH 16 DECIMALS 2.
PARAMETERS: PA_INT1 TYPE I,
            PA_OP TYPE C,
            PA_INT2 TYPE I.
DATA : GV_RESULT TYPE TV_RESULT."결과값 집어넣을 변수"
*data : go_obj type ref to zcl_compute_05. "참조변수 생성
*create object go_obj."참조변수를 연결해줌
"pattern -> abap object pattern -> create object -> object = go_obj, class = zcl_compute_05

CLASS lcl_compute_05 DEFINITION. "local class 정의
  PUBLIC SECTION. "public 부분(모두가 사용가능해도 되는 부분)- public protected private 순으로 정의
    class-METHODS get_percentage "method 정의
                    IMPORTING iv_act TYPE i
                              iv_max TYPE i
                    EXPORTING ev_result TYPE bc400_perc.
endclass.
CLASS lcl_compute_05 IMPLEMENTATION.
  METHOD get_percentage.
      ev_result = iv_act / iv_max * 100.
   ENDMETHOD.
ENDCLASS.
start-OF-SELECTION.
IF pa_op = '+' or pa_op = '-' or pa_op = '/' or pa_op = '*' or pa_op = '%'. "+ - * / % 연산만 하도록 IF문으로 걸러줌"
  IF ( pa_int2 = 0 and pa_op = '/' ) or ( pa_int2 = 0 and pa_op = '%' ). "만약 0으로 나눈다면 에러 발생(이때 퍼센트 구하는 것도 나누는 값이 0이면 안됨"
    message i000(zmsg_class_05)."에러메시지 "divide by 0" 출력
   else."0으로 나눈 연산이 아니라면 가능"
     CASE pa_op."연산자로 경우를 나누어줌"
       WHEN '+'."덧셈 계산"
        gv_result = pa_int1 + pa_int2.
       WHEN '-'."뺄셈 계산"
        gv_result = pa_int1 - pa_int2.
       WHEN '*'."곱셈 계산"
        gv_result = pa_int1 * pa_int2.
       WHEN '/'."나눗셈 계산"
         gv_result = pa_int1 / pa_int2.
       WHEN '%'."퍼센트 연산은 subroutine으로 계산하라고 하였음"
"서브루틴으로 하는법
*         PERFORM CALC_PERCENTAGE USING PA_INT1 PA_INT2 CHANGING GV_RESULT."서브루틴으로 값 구하기"
*         call function 'ZCALC_PERC_05' "FUNCTION MODULE을 호출함 (드래그해서 가져다두거나, 위의 PATTERN버튼을 눌러서 생성)
*           exporting "프로그램에서 FUNCTION MODULE로 내보내줄 값을 지정
*             iv_int1 = PA_INT1 "FUNCTION MODULE의 IV_INT1에 지금 프로그램(ZBC400_05_SUBROUTINE)의 PA_INT1을 보내줌
*             iv_int2 = PA_INT2 "FUNCTION MODULE의 IV_INT2에 지금 프로그램(ZBC400_05_SUBROUTINE)의 PA_INT2을 보내줌
*          IMPORTING "FUNCTION MODULE에서 프로그램으로 받아올 값을 지정
*            EV_RESULT = GV_RESULT "FUNCTION MODULE에서 퍼센트 계산을 완료한 EV_RESULT값을 현재 프로그램의 GV_RESULT에 넣어줌
*          EXCEPTIONS "FUNCION MODULE에서 EXCEPTION에 지정해놓은 예외의 상황이 발생한 경우에 SY-SUBRC의 값을 지정해주는 것
*            NO_ZERO = 1 "0으로 나누는 경우에 SY_SUBRC = 1으로 지정
*            OTHERS  = 2 "NO_ZERO이외의 별도로 추가 EXCEPTION이 있는 경우에 그 예외가 발생하면 SY_SUBRC = 2로 지정
*           .
*         if sy-subrc <> 0. "SY-SUBRC가 0이 아닌 경우에는 에러가 발생한 것이므로 에러에 대해서 처리를 해주기위해서 사용
*           CASE SY-SUBRC.
*             WHEN 1. " 1번 에러(0으로 나눈경우)가 발생하면 이렇게 처리해주겠다.
*              WRITE:/ 'DIVIDE BY 0'.
*             WHEN 2. " 2번 에러(OTHERS)가 발생하면 이렇게 처리해주겠다.
*              WRITE:/ '에러 발생'.
*           ENDCASE.

"local class 사용
call METHOD lcl_compute_05=>get_percentage
  exporting
    iv_act = pa_int1
    iv_max = pa_int2
  importing
    ev_result = gv_result.

"TRY CATCH로 클래스 사용
*TRY. "TRY문 안에 있는 함수들을 시도해보고
*           call method zcl_compute_05=>get_percentage "ZCL_COMPUTE_05 CLASS의 GET_PERCENTAGE METHOD 불러옴
*           exporting "매소드로 내보내줄 변수
*             iv_act = PA_INT1
*             iv_max = PA_INT2
*           importing "매소드에서 받아올 변수
*            ev_result = GV_RESULT.
*CATCH ZCX_NO_ZERO. "에러가 나면 CATCH문으로 와서 실행(이때 ZCX_NO_ZERO 이 에러는 클래스에서 에러클래스를 만들어줘야함)
*"에러 클래스 만드는법 https://m.blog.naver.com/PostView.nhn?blogId=aaaa123krkr&logNo=220766252820&proxyReferer=https%3A%2F%2Fwww.google.com%2F
*  WRITE:/ '0으로 나눴삼'.
*ENDTRY.

"클래스 사용(instance) - 클래스를 사용할 때마다 각각의 오브젝트를 따로 생성해줘야하는 방법
"pattern -> abap object pattern -> call method -> object : go_obj, class : zcl_compute_05, method : get_percentage
*call method go_obj->get_percentage "만들어준 오브젝트에 동작을 어떻게 할지 매칭해줌
*  exporting
*    iv_act      = pa_int1
*    iv_max      = pa_int2
*  importing
*    ev_result   = gv_result
*  exceptions
*    zcx_no_zero = 1
*    others      = 2.
*if sy-subrc <> 0.
*  CASE sy-subrc.
*    WHEN 1.
*      write:/ 'devide by 0'.
*    WHEN 2.
*      write:/ 'error'.
*    WHEN OTHERS.
*  ENDCASE.
*endif.


"클래스 사용(STATIC) 클래스에 하나로 존재하는 매소드
*         call method zcl_compute_05=>get_percentage "ZCL_COMPUTE_05 CLASS의 GET_PERCENTAGE METHOD 불러옴
*           exporting "매소드로 내보내줄 변수
*             iv_act = PA_INT1
*             iv_max = PA_INT2
*           importing "매소드에서 받아올 변수
*            ev_result = GV_RESULT
*           exceptions " 예외 처리
*            no_zero   = 1 "0으로 나눈 경우 SY-SUBRC = 1
*            others = 2 "나머지 에러는 SY-SUBRC = 2
*           .
*         if sy-subrc <> 0. "에러에 대한 처리
*          CASE SY-SUBRC.
*             WHEN 1.
*              WRITE:/'DIVIDE BY 0'.
*             WHEN 2.
*              WRITE:/'ERROR'.
*             WHEN OTHERS.
*           ENDCASE.
*         endif.
       ENDCASE.
        endif.


      write : 'gv_result : ', gv_result. " 결과값 출력"
  ENDIF.
*  else."만약 연산자가 잘못됬을 경우에는 위의 if문에 못들어가고 else로 넘어옴"
*    message s001(zmsg_class_05) with pa_op sy-uname sy-langu sy-uzeit.
*ENDIF.
"서프루틴 정의
*form calc_percentage  using    VALUE(PV_ACT) TYPE I "call by value(변경 안할 값), pa_int1과 연결됨"
*                               VALUE(PV_MAX) TYPE I "call by value(변경 안할 값), pa_int2와 연결됨"
*                      changing CV_RESULT TYPE TV_RESULT. "call by reference(서브루틴에서 변경되면 바로 메모리 영역에서 변경해줌), gv_result와 연결됨"
*  CV_RESULT = PV_ACT / PV_MAX * 100. "% 연산해서 result값 변경"
*endform.
