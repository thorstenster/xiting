CLASS zcl_xi_custom DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
* @ObjectModel.query.implementedBy: 'ABAP:ZCL_XI_CUSTOM'
    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_xi_custom IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
  ENDMETHOD.
ENDCLASS.
