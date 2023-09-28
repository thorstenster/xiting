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
    DATA:
      lt_partner     TYPE STANDARD TABLE OF zxipartner,
      lt_partnerrole TYPE STANDARD TABLE OF zxipartnerrole.
    DELETE FROM zxipartner.
    DELETE FROM zxipartnerrole.
    TRY.
        lt_partner = VALUE #( ( partner = '0000000001' name_first = 'Willi' name_last = 'Winzing'
                                guid = cl_system_uuid=>create_uuid_x16_static(  ) )
                               ( partner = '0000000002' name_first = 'Horst' name_last = 'Schlemmer'
                                guid = cl_system_uuid=>create_uuid_x16_static(  ) )
                                ).
        lt_partnerrole = VALUE #(
        ( partner = '0000000001' partnerrole = 'DEVELOPER'
         guid = cl_system_uuid=>create_uuid_x16_static(  )
         parent_guid = lt_partner[ 1 ]-guid
         )
         ( partner = '0000000001' partnerrole = 'TESTER'
         guid = cl_system_uuid=>create_uuid_x16_static(  )
         parent_guid = lt_partner[ 1 ]-guid
         )
        ( partner = '0000000002' partnerrole = 'DEVELOPER'
         guid = cl_system_uuid=>create_uuid_x16_static(  )
         parent_guid = lt_partner[ partner = '0000000002' ]-guid
         )
         ( partner = '0000000002' partnerrole = 'USER'
         guid = cl_system_uuid=>create_uuid_x16_static(  )
         parent_guid = lt_partner[ partner = '0000000002' ]-guid
         )

          ).
      CATCH cx_uuid_error.
        "handle exception
    ENDTRY.
    out->write( lt_partner ).
    out->write( lt_partnerrole ).
    INSERT zxipartner FROM TABLE @lt_partner.
    out->write( sy-subrc ).
    INSERT zxipartnerrole FROM TABLE @lt_partnerrole.
    out->write( sy-subrc ).
  ENDMETHOD.

ENDCLASS.
