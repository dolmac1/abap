REPORT ZEX1_2_PRG_05.

PARAMETERS num TYPE i.
data result TYPE i value 1.
IF num < 2.
   message s002(zmsg_class_05).
  elseif num >= 10.
   message s003(zmsg_class_05).
  else.
    DO num TIMES.
      write: sy-index.
      IF sy-index = num.
        write:'='.
        else.
          write:'*'.
      ENDIF.
      result = result * sy-index.
    ENDDO.
    write: result.
ENDIF.
