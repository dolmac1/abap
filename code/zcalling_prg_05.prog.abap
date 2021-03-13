*&---------------------------------------------------------------------*
*& Report ZCALLING_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zcalling_prg_05.

data: gt_bdcdata type table of bdcdata, "호출할 프로그램에 보내줄 값들을 저장할 테이블
      gs_bdcdata like line of gt_bdcdata. "테이블에 값들을 넣기위한 스트럭쳐

gs_bdcdata-program = 'SAPBC402_PGCD_CREATE_CUSTOMER'. "호출할 프로그램이름을 지정
gs_bdcdata-dynpro = '0100'. "호출할 프로그램의 스크린 번호를 지정
gs_bdcdata-dynbegin = 'X'.
append gs_bdcdata to gt_bdcdata. "테이블의 첫줄에 넣음

clear: gs_bdcdata. "스트럭쳐 CLEAR시킴
gs_bdcdata-fnam = 'SCUSTOM-NAME'. "필드 이름 지정
gs_bdcdata-fval = '뽀삐'. "그 필드에 넣을 데이터 설정
append gs_bdcdata to gt_bdcdata.

gs_bdcdata-fnam = 'SCUSTOM-CITY'. "필드 이름 지정
gs_bdcdata-fval = '강원도 평택시'. " 그 필드에 넣을 데이터 설정
append gs_bdcdata to gt_bdcdata.

*ㅣ--------------------------------ㅣ--------ㅣ----------ㅣ-----------------ㅣ-------------ㅣ
*ㅣ              program           ㅣ dynpro ㅣ dynbegin ㅣ fnam            ㅣ fval        ㅣ
*ㅣ SAPBC402_PGCD_CREATE_CUSTOMER  ㅣ  0100  ㅣ   X      ㅣ                 ㅣ             ㅣ
*ㅣ--------------------------------ㅣ--------ㅣ----------ㅣ-----------------ㅣ-------------ㅣ
*ㅣ                                ㅣ        ㅣ          ㅣ  SCUSTOM-NAME   ㅣ  뽀삐        ㅣ
*ㅣ--------------------------------ㅣ--------ㅣ----------ㅣ-----------------ㅣ-------------ㅣ
*ㅣ                                ㅣ        ㅣ          ㅣ  SCUSTOM-CITY   ㅣ  강원도 평택시  ㅣ
*ㅣ--------------------------------ㅣ--------ㅣ----------ㅣ-----------------ㅣ-------------ㅣ

call transaction 'BC402_CALD_CRE_CUST' "T CODE가 BC402_CALD_CRE_CUST인 프로그램을 호출하는데
using gt_bdcdata "gt_bdcdata를 넣어서 호출하고
mode 'A'. "에러가 나던 잘 되던 보여줌
