*&---------------------------------------------------------------------*
*& Report ZHELLO_PRG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZHELLO_PRG_05.
parameters a type i.
parameters c type x length 10.
do a times.
  parameters b type i.
  do b times.
    write '*'.
  enddo.
enddo.

parameters k type p length 5 decimals 2.

write:/ k.
