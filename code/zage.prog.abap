*&---------------------------------------------------------------------*
*& Report ZAGE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZAGE.
PARAMETERS BIR_DAYS TYPE DATS. "생일을 입력하는 변수
DATA : MY_AGE TYPE I, "나이를 받아올 변수
      MY_AGE2 TYPE I. "만 나이를 받아올 변수

call function 'ZGET_AGE_05' "나이 구하는 FUNCTION MODULE을 호출함
  exporting "모듈로 내보내주는 변수
    iv_birdt = BIR_DAYS "BIR_DAYS변수를 모듈의 IV_BIRDT로 보내줌
 IMPORTING
   EV_AGE1  = MY_AGE "모듈의 EV_AGE1값(나이)를 받아와서 MY_AGE에 넣어줌
   EV_AGE2  = MY_AGE2. "모듈의 EV_AGE2값(만 나이)를 받아와서 MY_AGE2에 넣어줌
WRITE:/'내 나이는 ', MY_AGE, '살이고 만으로는 ', MY_AGE2, '살입니다.'. " 출력
