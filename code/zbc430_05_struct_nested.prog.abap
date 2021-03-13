*&---------------------------------------------------------------------*
*& Report  SAPBC430S_STRUCT_NESTED                                     *
*&                                                                     *
*&---------------------------------------------------------------------*
*&                                                                     *
*&                                                                     *
*&---------------------------------------------------------------------*

REPORT  zbc430_05_struct_nested                                     .

*Replace ## by Your group- or screennumber and
*uncomment the ABAP-coding

DATA wa_person TYPE zperson05.

START-OF-SELECTION.

  wa_person-name-firstname = 'Harry'. "nested structure로 선언됬을 경우 변수에 값을 넣는 과정
  wa_person-name-lastname = 'Potter'.

  wa_person-street = 'Privet Drive'. "sturucture 타입을 만들때 nested 대신 .include를 사용했을때 변수에 값을 넣는 과정
  wa_person-nr = '3'.
  wa_person-zip = 'GB-10889'.
  wa_person-city = 'London'.

  WRITE: /  wa_person-name-firstname , "출력
            wa_person-name-lastname ,
            wa_person-street ,
            wa_person-nr ,
            wa_person-zip ,
            wa_person-city .
