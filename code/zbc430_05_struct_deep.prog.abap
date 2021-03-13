*&---------------------------------------------------------------------*
*& Report  SAPBC430S_STRUCT_NESTED                                     *
*&                                                                     *
*&---------------------------------------------------------------------*
*&                                                                     *
*&                                                                     *
*&---------------------------------------------------------------------*

REPORT  zbc430_05_struct_deep                                     .

*Replace ## by Your group- or screennumber and
*uncomment the ABAP-coding

*PARAMETERS wa_check TYPE str_phone-p_type value check. "그냥 안에 value가 뭐있나 확인해볼라고 만든것
DATA wa_person TYPE zperson05.

data: wa_phone TYPE str_phone.
START-OF-SELECTION.
  wa_person-name-firstname = 'Harry'. "nested structure로 선언됬을 경우 변수에 값을 넣는 과정
  wa_person-name-lastname = 'Potter'.

  wa_person-street = 'Privet Drive'. "sturucture 타입을 만들때 nested 대신 .include를 사용했을때 변수에 값을 넣는 과정
  wa_person-nr = '3'.
  wa_person-zip = 'GB-10889'.
  wa_person-city = 'London'.

  wa_phone-p_type = 'M'. "STRUCTURE 안의 TABLE에 넣기위해서 WORKAREA에 값 설정
  wa_phone-p_number = '010-1234-5678'.
  INSERT WA_PHONE INTO TABLE WA_PERSON-phone. "테이블의 맨 마지막에 추가
*  append wa_phone to wa_person-phone.

  wa_phone-p_type = 'P'."STRUCTURE 안의 TABLE에 넣기위해서 WORKAREA에 값 설정
  wa_phone-p_number = '010-2345-6789'.
  INSERT WA_PHONE INTO TABLE WA_PERSON-phone."STRUCTURE 안의 TABLE에 넣기위해서 WORKAREA에 값 설정

  wa_phone-p_type = 'F'."STRUCTURE 안의 TABLE에 넣기위해서 WORKAREA에 값 설정
  wa_phone-p_number = '010-3456-7890'.
  INSERT WA_PHONE INTO TABLE WA_PERSON-phone."STRUCTURE 안의 TABLE에 넣기위해서 WORKAREA에 값 설정
  "만약에 wa_phone = 'p00-1234-2345'이라고 선언하면 알아서 p_type에 앞에 3글자를 넣어주고 나머지는 p_number로 넣음


  WRITE: /  wa_person-name-firstname , "출력
            wa_person-name-lastname ,
            wa_person-street ,
            wa_person-nr ,
            wa_person-zip ,
            wa_person-city .
write:/'phone number : '.
  LOOP AT wa_person-phone into wa_phone. "DEEP STRUCTURE의 TABLE 출력
    write:at 20 wa_phone-p_type, wa_phone-p_number.
    NEW-LINE.
  ENDLOOP.
