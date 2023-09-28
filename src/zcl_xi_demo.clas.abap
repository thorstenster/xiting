CLASS zcl_xi_demo DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_xi_demo IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    cl_numberrange_intervals=>create(
      EXPORTING
        interval  = value #( ( nrrangenr = '01' fromnumber = '0000000001' tonumber = '9999999999'
        nrlevel = '0000000001'
         ) )

        object    = 'ZXIPARTNER'
    ).


    ENDMETHOD.

ENDCLASS.
