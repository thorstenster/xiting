CLASS lhc_ZXI_I_Role DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR ZXI_I_Role RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR role RESULT result.

    METHODS roleactivate FOR MODIFY
      IMPORTING keys FOR ACTION role~roleactivate RESULT result.

    METHODS roledeactivate FOR MODIFY
      IMPORTING keys FOR ACTION role~roledeactivate RESULT result.

ENDCLASS.

CLASS lhc_ZXI_I_Role IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD roleActivate.
  ENDMETHOD.

  METHOD roleDeactivate.
  ENDMETHOD.

ENDCLASS.
