*&---------------------------------------------------------------------*
*& Report ZCALLED_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCALLED_PRG_05. "zbc400_05_rep_a에서 호출함

data : lt_spfli TYPE TABLE OF spfli,
       ls_spfli LIKE LINE OF lt_spfli.

data: gt_data TYPE bc400_t_flights,
      gs_data TYPE bc400_s_flight.

PARAMETERS : pa_car TYPE spfli-carrid.

*메모리에서 받아오는 곳
import flight = gt_data from MEMORY id 'id_05'.
"아밥 메모리에 올린 flight라는 internal table을 받아서 gt_data에 넣음(올린 id =id05)

loop at gt_data into gs_data. "받아온 테이블 출력해보기
write:/ gs_data-carrid,
gs_data-connid,
gs_data-fldate,
gs_data-percentage.
ENDLOOP.

*SELECT * into table lt_spfli
*  from spfli
*  where carrid = pa_car.
*
*  loop at lt_spfli into ls_spfli.
*    write:/ ls_spfli-airpfrom,
*            ls_spfli-airpto,
*            ls_spfli-arrtime,
*            ls_spfli-carrid,
*            ls_spfli-cityfrom,
*            ls_spfli-cityto,
*            ls_spfli-connid,
*            ls_spfli-countryfr,
*            ls_spfli-countryto,
*            ls_spfli-deptime,
*            ls_spfli-distance,
*            ls_spfli-distid,
*            ls_spfli-fltime,
*            ls_spfli-fltype,
*            ls_spfli-mandt,
*            ls_spfli-period.
*  ENDLOOP.
