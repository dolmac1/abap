*&---------------------------------------------------------------------*
*& Report ZDEEP_STRU_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDEEP_STRU_05.


data: gs_emp TYPE zsemp1_05. "deep structure로 변수 선언(structure안에 테이블이 있는것)

data: gs_tel LIKE LINE OF gs_emp-telno. "gs_emp안의 테이블 telno에 값을 넣기위해 workarea로 사용할 structure

gs_emp-pernr = 10001.
gs_emp-orgeh = 11001.
gs_emp-orgtx = '재경팀'.

gs_tel-telno = '010-123-456-7890'. "gs_emp에 넣어줄 값을 workarea gs_tel에 넣어줌
append gs_tel to gs_emp-telno. "gs_emp의 telno 테이블에 삽입
gs_tel-telno = '02-346-6789'.
append gs_tel to gs_emp-telno.
gs_tel-telno = '789-123-4567'.
append gs_tel to gs_emp-telno.

write:/ gs_emp-pernr, gs_emp-orgeh, gs_emp-orgtx. "structure안의 값 출력

LOOP AT gs_emp-telno into gs_tel. "structure안의 table값 출력
  write: gs_tel-telno.
ENDLOOP.
