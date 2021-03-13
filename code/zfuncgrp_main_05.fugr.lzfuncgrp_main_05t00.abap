*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 2019-07-31 at 11:56:54
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZPARTNER05......................................*
TABLES: ZPARTNER05, *ZPARTNER05. "view work areas
CONTROLS: TCTRL_ZPARTNER05
TYPE TABLEVIEW USING SCREEN '0300'.
DATA: BEGIN OF STATUS_ZPARTNER05. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZPARTNER05.
* Table for entries selected to show on screen
DATA: BEGIN OF ZPARTNER05_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZPARTNER05.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZPARTNER05_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZPARTNER05_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZPARTNER05.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZPARTNER05_TOTAL.

*...processing: ZVSCARR_05M.....................................*
TABLES: ZVSCARR_05M, *ZVSCARR_05M. "view work areas
CONTROLS: TCTRL_ZVSCARR_05M
TYPE TABLEVIEW USING SCREEN '0100'.
DATA: BEGIN OF STATUS_ZVSCARR_05M. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZVSCARR_05M.
* Table for entries selected to show on screen
DATA: BEGIN OF ZVSCARR_05M_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZVSCARR_05M.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSCARR_05M_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZVSCARR_05M_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZVSCARR_05M.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSCARR_05M_TOTAL.

*...processing: ZVSPFLI_05M.....................................*
TABLES: ZVSPFLI_05M, *ZVSPFLI_05M. "view work areas
CONTROLS: TCTRL_ZVSPFLI_05M
TYPE TABLEVIEW USING SCREEN '0500'.
DATA: BEGIN OF STATUS_ZVSPFLI_05M. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZVSPFLI_05M.
* Table for entries selected to show on screen
DATA: BEGIN OF ZVSPFLI_05M_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZVSPFLI_05M.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSPFLI_05M_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZVSPFLI_05M_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZVSPFLI_05M.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSPFLI_05M_TOTAL.

*.........table declarations:.................................*
TABLES: SBUSPART                       .
TABLES: STRAVELAG                      .
TABLES: ZTSCARR_05                     .
TABLES: ZTSPFLI_05                     .
