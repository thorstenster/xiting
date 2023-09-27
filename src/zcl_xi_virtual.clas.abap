CLASS zcl_xi_virtual DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
* @ObjectModel.virtualElement: true
* @ObjectModel.virtualElementCalculatedBy: 'ZCL_XI_VIRTUAL'
    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_xi_virtual IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
  ENDMETHOD.
ENDCLASS.
