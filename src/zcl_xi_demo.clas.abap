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
    TRY.
        cl_numberrange_intervals=>create(
          EXPORTING
            interval  = VALUE #( ( nrrangenr = '01' fromnumber = '0000000001' tonumber = '9999999999'
            nrlevel = '0000000001'
             ) )

            object    = 'ZXIPARTNER'
        ).
      CATCH cx_number_ranges.
        "handle exception
    ENDTRY.


    ENDMETHOD.

ENDCLASS.
