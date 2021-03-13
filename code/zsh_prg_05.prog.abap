*&---------------------------------------------------------------------*
*& Report ZSH_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSH_PRG_05.

PARAMETERS : pa_dept TYPE ztemp_05-orgeh. "서치헬프 테스트하는 것. "se11에 zshdept_05가 search help로 설정됨
*search help에서 dialog type이 보통은 display values immediately사용
*목록이 너무 많으면 dialog with value restriction
*목록의 수에 따라 자동으로 골라주는  dialog depends on set of values

PARAMETERS : pa_chr TYPE char3 MATCHCODE OBJECT zshdept_05.
*프로그램에서 서치헬프 사용하는법
PARAMETERS : pa_emp TYPE ztemp_05-pernr, "사번(pernr)을 보면 이름도 같이 나오게 하는 search help가 pernr 필드에 지정되어있음
             pa_name  TYPE ztemp_05-ename.
call screen 100. "만들어둔 스크린을 호출할때는 call screen 함수를 사용해서 호출

PARAMETERS : pa_id TYPE s_customer MATCHCODE OBJECT zshcustom_05. "서치 헬프가 미리 정해져있어도 data base table에 지정된게 우선순위

"이때 search help의 설정에 따라 숫자를 입력해야하는 칸에 문자로도 검색가능(multi column full text search)
*search help의 import는 table에서 가져올때 조건을 걸어주는 필드, export는 더블클릭하면 받아와질 필드지정
