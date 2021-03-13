*&---------------------------------------------------------------------*
*& Report ZSYNTAX_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zsyntax_prg_05.

parameters pa_num type i.
*인풋필드
data gv_result type i.

move pa_num to gv_result.
*gv_result = pa_num
* *은 줄전체주석 "는 뒤부터 주석
write: gv_result,
pa_num.
* : ,으로 같은 키워드를 한번에 처리가능
new-line.
add 1 to gv_result.
* gv_result = gv_result + 1.
write gv_result.
*파라미터는 한번 입력받으면 고정이\]
