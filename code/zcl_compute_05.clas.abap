class ZCL_COMPUTE_05 definition
  public
  final
  create public .

public section.

  methods GET_PERCENTAGE
    importing
      !IV_ACT type BC400_ACT
      !IV_MAX type I
    exporting
      !EV_RESULT type BC400_PERC
    exceptions
      ZCX_NO_ZERO .
  class-methods GET_CONNECTION
    exporting
      !ET_CONNECTIONS type ZYCONNECTION_05 .
protected section.
private section.
ENDCLASS.



CLASS ZCL_COMPUTE_05 IMPLEMENTATION.


  method GET_CONNECTION.
    select * into CORRESPONDING FIELDS OF table et_connections from spfli.
  endmethod.


  method GET_PERCENTAGE. "GET_PERCENTAGE 매소드에 대해서 어떤 동작을 처리해줄지
    IF IV_MAX = 0. "나눌 값이 0이면
      EV_RESULT = 0. "나눌수가 없으니까 결과를 0으로 해주고
      RAISE ZCX_NO_ZERO. "에러처리
    ELSE. "나눌 값이 0이 아닌 경우에는
      EV_RESULT = IV_ACT / IV_MAX * 100. "퍼센트 계산
    ENDIF.
  endmethod.
ENDCLASS.
