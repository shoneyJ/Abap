*&---------------------------------------------------------------------*
*& Report ZS006TASK4
*&---------------------------------------------------------------------*
*& Aufgabe: change the program into an ABAP OO program (one class with static method main())
*& use a parameter if the log should be desplayed (function module BAL_DSP_LOG_DISPLAY)
*& transaction SLG0: definition of LOG Objects and subobjects (please don't mainaint anything)
*& transaction SLG1: display LOG
*&---------------------------------------------------------------------*
REPORT zs006task04.


CLASS gc_main DEFINITION.
  PUBLIC SECTION.

    CLASS-METHODS:
      main IMPORTING iv_show_log TYPE abap_bool
                     iv_cnt      TYPE i.
*
*  PROTECTED SECTION.
*    CLASS-METHODS:

ENDCLASS.

CLASS gc_main IMPLEMENTATION.
*
*
  METHOD main.

    DATA i_s_log TYPE bal_s_log.
    DATA e_log_handle TYPE balloghndl.

    i_s_log-object = 'ZT001'. "<TODO>"
    i_s_log-subobject = 'ZTS01'.



    CALL FUNCTION 'BAL_LOG_CREATE'
      EXPORTING
        i_s_log                 = i_s_log
      IMPORTING
        e_log_handle            = e_log_handle
      EXCEPTIONS
        log_header_inconsistent = 1
        OTHERS                  = 2.
    IF sy-subrc <> 0.
      WRITE 'error'.
    ENDIF.

    DO iv_cnt TIMES.
      MESSAGE e003(zs006_test) WITH 'hallo Shoney' INTO DATA(lv_dummy).
      .
      DATA i_s_msg TYPE bal_s_msg.

      MOVE-CORRESPONDING sy TO i_s_msg.

      CALL FUNCTION 'BAL_LOG_MSG_ADD'
        EXPORTING
          i_log_handle     = e_log_handle
          i_s_msg          = i_s_msg
        EXCEPTIONS
          log_not_found    = 1
          msg_inconsistent = 2
          log_is_full      = 3
          OTHERS           = 4.
      IF sy-subrc <> 0.
        WRITE 'error message add'.
      ENDIF.

    ENDDO.

    DATA i_t_log_handle TYPE bal_t_logh.
    INSERT e_log_handle INTO TABLE i_t_log_handle.
    CALL FUNCTION 'BAL_DB_SAVE'
      EXPORTING
        i_t_log_handle   = i_t_log_handle
      EXCEPTIONS
        log_not_found    = 1
        save_not_allowed = 2
        numbering_error  = 3
        OTHERS           = 4.
    IF sy-subrc <> 0.
      WRITE 'error log save'.
    ELSE.
      WRITE 'no error during log save'.
    ENDIF.

    "here: persist data in database
    COMMIT WORK. "COMMIT WORK. -> "LUW"

    DATA e_s_exit_command  TYPE bal_s_excm.


    IF iv_show_log = abap_true.
      CALL FUNCTION 'BAL_DSP_LOG_DISPLAY'
        EXPORTING
*         I_S_DISPLAY_PROFILE  =
          i_t_log_handle       = i_t_log_handle
*         I_T_MSG_HANDLE       =
*         I_S_LOG_FILTER       =
*         I_S_MSG_FILTER       =
*         I_T_LOG_CONTEXT_FILTER              =
*         I_T_MSG_CONTEXT_FILTER              =
*         I_AMODAL             = ' '
*         I_SRT_BY_TIMSTMP     = ' '
*         I_MSG_CONTEXT_FILTER_OPERATOR       = 'A'
        IMPORTING
          e_s_exit_command     = e_s_exit_command
        EXCEPTIONS
          profile_inconsistent = 1
          internal_error       = 2
          no_data_available    = 3
          no_authority         = 4
          OTHERS               = 5.
      IF sy-subrc <> 0.
        WRITE 'error log display'.
      ENDIF.
    ENDIF.


  ENDMETHOD.


ENDCLASS.


PARAMETERS p_show TYPE abap_bool AS CHECKBOX .
PARAMETERS p_cnt TYPE i  DEFAULT 10.

START-OF-SELECTION.

  gc_main=>main( iv_show_log = p_show
                  iv_cnt = p_cnt ).