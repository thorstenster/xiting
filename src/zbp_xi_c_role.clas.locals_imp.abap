CLASS lhc_Role DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Role RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Role RESULT result.

    METHODS roleActivate FOR MODIFY
      IMPORTING keys FOR ACTION Role~roleActivate RESULT result.

    METHODS roleDeactivate FOR MODIFY
      IMPORTING keys FOR ACTION Role~roleDeactivate RESULT result.

ENDCLASS.

CLASS lhc_Role IMPLEMENTATION.

  METHOD get_instance_features.
    READ ENTITIES OF ZXI_C_Role IN LOCAL MODE
      ENTITY Role
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(roles).
    result = VALUE #( FOR key IN keys LET role = roles[ %tky = key-%tky ] IN
    ( %tky = key-%tky
      %action-roleActivate   = COND #( WHEN role-Active = abap_false THEN if_abap_behv=>fc-o-enabled
                                       ELSE                               if_abap_behv=>fc-o-disabled )
      %action-roleDeactivate = COND #( WHEN role-Active = abap_false THEN if_abap_behv=>fc-o-disabled
                                       ELSE                               if_abap_behv=>fc-o-enabled  ) ) ).
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD roleActivate.
    MODIFY ENTITIES OF ZXI_C_Role IN LOCAL MODE
      ENTITY Role
      UPDATE FIELDS ( Active )
      WITH VALUE #( FOR key IN keys ( %tky   = key-%tky
                                      Active = abap_true ) )
      FAILED   failed
      MAPPED   mapped
      REPORTED reported.

    READ ENTITIES OF ZXI_C_Role IN LOCAL MODE
      ENTITY Role
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(roles).
    result = VALUE #( FOR key IN keys ( %cid_ref = key-%cid_ref
                                        %tky     = key-%tky
                                        %param   = roles[ %tky = key-%tky ] ) ).

  ENDMETHOD.

  METHOD roleDeactivate.

    MODIFY ENTITIES OF ZXI_C_Role IN LOCAL MODE
      ENTITY Role
      UPDATE FIELDS ( Active )
      WITH VALUE #( FOR key IN keys ( %tky   = key-%tky
                                      Active = abap_false ) )
      FAILED   failed
      MAPPED   mapped
      REPORTED reported.

    READ ENTITIES OF ZXI_C_Role IN LOCAL MODE
      ENTITY Role
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(roles).
    result = VALUE #( FOR key IN keys ( %cid_ref = key-%cid_ref
                                        %tky     = key-%tky
                                        %param   = roles[ %tky = key-%tky ] ) ).
  ENDMETHOD.

ENDCLASS.
