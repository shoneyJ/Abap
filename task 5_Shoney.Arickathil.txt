*&---------------------------------------------------------------------*
*& Report ZS006_TASK5
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs006_task5.
*&---------------------------------------------------------------------*
*& Report ZT001_TASK05
*&---------------------------------------------------------------------*
*& task: read the ABAP help about pattern-based character substitutions
*& (REPLACE)
*& complete the program Ergänze das Programm, so that the placeholder "[X]" are
*& replaced from the values in the table
*& please use a class for this
*&---------------------------------------------------------------------*

CLASS cl_replace DEFINITION.

  PUBLIC SECTION.
    CLASS-METHODS:
      main.

ENDCLASS.

CLASS cl_replace IMPLEMENTATION.

  METHOD main.
    TYPES: BEGIN OF tsy_nv,
             name  TYPE text30,
             value TYPE string,
           END OF tsy_nv.

    DATA: gt_nv     TYPE TABLE OF tsy_nv,
          gv_text   TYPE string,
          gs_return TYPE bapiret2,
          gt_return TYPE bapiret2_tab.



    gt_nv = VALUE #( ( name = 'V1' value = 'Herr Schmitt' )
    ( name = 'V2' value = 'Herr und Frau Schmitt' )
    ( name = 'V3' value = '++++' )
    ( name = 'V7' value = '17' ) ).

    gv_text = |V1 = [V1], [V2], ----[V3]---- [V4]|.

* substitute variables
    LOOP AT gt_nv INTO DATA(lv_nv) .

      CONCATENATE '[' lv_nv-name ']' INTO DATA(str).
      REPLACE  str IN gv_text WITH lv_nv-value.

      IF sy-subrc = 4.
        DATA result TYPE string.

        SEARCH gv_text FOR '['.

        IF sy-fdpos <> 0.
          result = substring( val = gv_text off = sy-fdpos  len = 4 ).

          MESSAGE e005(zs006_test) WITH result INTO DATA(gv_msg).
          gs_return-message = gv_msg.

          APPEND gs_return TO gt_return.
        ENDIF.





      ENDIF.

    ENDLOOP.



    cl_demo_output=>new(


    )->next_section( 'Ersetzter Text'
    )->write( gv_text
    )->next_section( 'Fehler'
    )->write( gt_return
    )->display( ).

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  cl_replace=>main( ).


  "expected output:
*
*V1 = Herr Schmitt, Herr und Frau Schmitt, +++ [V4]
*
*errors: token [V4] not found