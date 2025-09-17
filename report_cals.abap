*&---------------------------------------------------------------------*
*& Report ZS006CALCULATOR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs006calculator.

PARAMETERS p_num1 TYPE i.
PARAMETERS p_num2 TYPE i.
PARAMETERS p_op TYPE c.

START-OF-SELECTION.

TRY.

  IF p_op = '+' .
    WRITE | { p_num1 + p_num2 } |.
  ELSEIF p_op = '-'.
    WRITE | { p_num1 - p_num2 } |.
  ELSEIF p_op = '*'.
    WRITE | { p_num1 * p_num2 } |.
    ELSEIF p_op = '/'.
    WRITE | { p_num1 / p_num2 } |.
  ELSE.


    WRITE | 'Enter valid operator' |.

  ENDIF.


  CATCH cx_sy_zerodivide.
    WRITE 'division by 0!'.
  CATCH zs006cx_ex_demo INTO DATA(lo_exp).
    WRITE lo_exp->get_longtext( ).

ENDTRY.