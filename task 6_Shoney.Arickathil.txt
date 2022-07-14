*&---------------------------------------------------------------------*
*& Report ZS006_TASK6
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs006_task6.


*& L-System
*& task: try to implement the Algae Lindenmayer System
*& (https://en.wikipedia.org/wiki/L-system -> Example 1: Algae)
*&---------------------------------------------------------------------*


CLASS lsys DEFINITION.
  PUBLIC SECTION.
    TYPES: BEGIN OF rule,
             input  TYPE string,
             output TYPE string,
           END OF rule.
    TYPES: rulestab TYPE STANDARD TABLE OF rule WITH EMPTY KEY.
    CLASS-METHODS main IMPORTING iterations TYPE i DEFAULT 10.
ENDCLASS.

CLASS lsys IMPLEMENTATION.
  METHOD main.

    DATA(axiom) = `A`.
    DATA(alphabet) = `AB`.
    DATA(rules) = VALUE rulestab( ( input = `A` output = `AB` )
    ( input = `B` output = `A` ) ).

    DATA pattern TYPE string.


*    pattern = axiom.
    DATA lv_offset TYPE i.
    DATA lv_n TYPE i.


    lv_offset = 0.

    DO iterations TIMES.

*      LOOP AT rules INTO (lv_rules).

*      ENDLOOP.
*       WRITE rules[ input = axiom   ]-output.


      lv_n = lv_n + 1.

      IF lv_n = 1.
        pattern =  rules[ input = axiom   ]-output.
        WRITE axiom.
        NEW-LINE.
      ELSE.


        pattern =  |{ pattern }{ rules[ input = axiom   ]-output }|.
      ENDIF.

      WRITE pattern.
      NEW-LINE.

      lv_offset = strlen( pattern ) - 1.

      axiom = pattern+lv_offset(1).
    ENDDO.





  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  lsys=>main( 5 ).


  "excpected output:

  "n = 0 : A
  "n = 1 : AB
  "n = 2 : ABA
  "n = 3 : ABAAB
  "n = 4 : ABAABABA
  "n = 5 : ABAABABAABAAB
  "n = 6 : ABAABABAABAABABAABABA
  "n = 7 : ABAABABAABAABABAABABAABAABABAABAAB