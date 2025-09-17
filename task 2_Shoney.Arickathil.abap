*&---------------------------------------------------------------------*
*& Report ZS006_TASK2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs006_task2.

CLASS gc_main DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main IMPORTING ir_part TYPE REF TO data .
ENDCLASS.

CLASS gc_main IMPLEMENTATION.
  METHOD main.
    FIELD-SYMBOLS <ir_part> TYPE ANY TABLE.
    ASSIGN ir_part->* TO <ir_part>.
    IF sy-subrc = 0.
*
      SELECT DISTINCT name_first , COUNT( * ) AS cnt
      INTO TABLE @DATA(lt_but)
      FROM zt001_but000
      UP TO 10 ROWS
*
      WHERE partner IN @<ir_part>   AND name_first <> ''
      GROUP BY name_first
      ORDER BY cnt DESCENDING.


        SELECT COUNT( DISTINCT name_first ) as cnt
          into table @DATA(lt_count)
          FROM zt001_but000

      .
    ENDIF.

*    DATA lt_count TYPE i.
*    lt_count = lines( lt_but ).
    cl_demo_output=>write(  data = lt_count ).
    cl_demo_output=>write(  data = lt_but ).
    cl_demo_output=>display(  ).
  ENDMETHOD.
ENDCLASS.

DATA gv_partner TYPE but000-partner.
SELECT-OPTIONS so_part FOR gv_partner .
*
*INITIALIZATION.
*  so_part[] = VALUE #( ( low = 1 high = 1000 sign = 'I' option = 'BT' ) ).

START-OF-SELECTION.
  gc_main=>main( ir_part = REF #( so_part[] ) ).