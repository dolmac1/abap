*&---------------------------------------------------------------------*
*& Report ZCOMP_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCOMP_PRG_05.

data: gs_scarr TYPE bc400_s_carrier.
"transparent table 타입(se11에 scarr 검색해보면 나옴)을 structure type으로 사용가능

PARAMETERS : pa_car TYPE s_carr_id.
*parameters : pa_car type bc400_s_carrier-carrid.도 가능
try. "중간에 catch에서 지정된 에러가 발생하면 바로 catch부분으로 넘어감
*pattern -> abap object pattern -> call method -> class : CL_BC400_FLIGHTMODEL, method : get_carrier
call method cl_bc400_flightmodel=>get_carrier "cl_bc400_flightmodel 클래스의 get_carrier 메소드를 사용하겠다
  exporting "클래스로 보내줄 값
    iv_carrid  = pa_car
  importing "클래스에서 받아올 값을 저장할 곳(structure)
    es_carrier = gs_scarr.
 catch cx_bc400_no_data .
 catch cx_bc400_no_auth .
endtry.

write:/ gs_scarr-carrid && ', ' && gs_scarr-carrname && ', ' && gs_scarr-currcode && ', ' && gs_scarr-url.
*받아온 값 출력 &&를 사이에 넣으면 공백이 없음 ``쓰면 공백
