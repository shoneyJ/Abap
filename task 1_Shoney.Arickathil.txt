REPORT zs006_task1.


*& task: write a programm to convert an arabic number between 1 and 3000
*& to a roman number.
*& example: 8 -> VIII
*& values:
*& 90 -> XC
*& 1000=M, 100=C, 10=X, 1=I, 500=D, 50=L, 5=V
*&---------------------------------------------------------------------*


PARAMETERS p_num TYPE i.
TYPES: BEGIN OF roman_type,

         key   TYPE i,
         value TYPE c LENGTH 1,
       END OF roman_type,
       t_roman_tab TYPE STANDARD TABLE OF roman_type WITH NON-UNIQUE KEY key.


DATA roman_table TYPE t_roman_tab.

DATA roman_struct TYPE roman_type.

data result type c LENGTH 10.


roman_table = VALUE #(
( key = 1000 value = 'M' )
( key = 500 value = 'D' )
( key = 100 value = 'C' )
( key = 50 value = 'L' )
( key = 10 value = 'X' )
( key = 5 value = 'V' )
( key = 1 value = 'I' )
 ).

WHILE p_num > 0.

  LOOP AT roman_table INTO roman_struct.

    IF p_num >= roman_struct-key.
      CONCATENATE result roman_struct-value INTO result.
      CONDENSE result NO-GAPS.
      p_num = p_num - roman_struct-key.

      EXIT.
    ENDIF.


  ENDLOOP.
ENDWHILE.


write result.