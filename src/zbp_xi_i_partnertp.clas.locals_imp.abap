CLASS lhc_partnerrole DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS determineRole FOR DETERMINE ON SAVE
      IMPORTING keys FOR PartnerRole~determineRole.

ENDCLASS.

CLASS lhc_partnerrole IMPLEMENTATION.

  METHOD determineRole.
    READ ENTITIES OF ZXI_I_PartnerTP IN LOCAL MODE
      ENTITY PartnerRole
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(roles).
    READ ENTITIES OF ZXI_I_PartnerTP IN LOCAL MODE
      ENTITY PartnerRole BY \_Partner
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(partners).
  ENDMETHOD.

ENDCLASS.

CLASS lhc_Partner DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Partner RESULT result.
    METHODS determinepartner FOR DETERMINE ON SAVE
      IMPORTING keys FOR partner~determinepartner.
    METHODS validatepartner FOR VALIDATE ON SAVE
      IMPORTING keys FOR partner~validatepartner.
    METHODS precheck_create FOR PRECHECK
      IMPORTING entities FOR CREATE partner.

    METHODS precheck_update FOR PRECHECK
      IMPORTING entities FOR UPDATE partner.
    METHODS partnerlock FOR MODIFY
      IMPORTING keys FOR ACTION partner~partnerlock RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR partner RESULT result.

    METHODS partnerunlock FOR MODIFY
      IMPORTING keys FOR ACTION partner~partnerunlock RESULT result.

ENDCLASS.

CLASS lhc_Partner IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD determinePartner.
    READ ENTITIES OF ZXI_I_PartnerTP IN LOCAL MODE
      ENTITY Partner
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(partners).

    LOOP AT partners ASSIGNING FIELD-SYMBOL(<partner>) WHERE Partner IS INITIAL.
      DATA: partnerid TYPE zxi_partner,
            number    TYPE cl_numberrange_runtime=>nr_number.
      TRY.
          cl_numberrange_runtime=>number_get(
            EXPORTING
              nr_range_nr       = '01'
              object            = 'ZXIPARTNER'
             IMPORTING
               number            = number ).
        CATCH cx_number_ranges.
          "handle exception
      ENDTRY.
      MODIFY ENTITIES OF ZXI_I_PartnerTP IN LOCAL MODE
        ENTITY Partner
          UPDATE FIELDS ( Partner )
          WITH VALUE #( ( %tky = <partner>-%tky Partner = number+10(10) ) ).
    ENDLOOP.
  ENDMETHOD.

  METHOD validatePartner.
    READ ENTITIES OF ZXI_I_PartnerTP IN LOCAL MODE
      ENTITY Partner
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(partners).
    failed-partner = VALUE #( FOR partner IN partners WHERE ( FirstName IS INITIAL )
                                ( %tky        = partner-%tky
                                  %fail-cause = if_abap_behv=>cause-unspecific ) ).
    reported-partner = VALUE #( FOR partner IN partners WHERE ( FirstName IS INITIAL )
                                ( %tky        = partner-%tky
                                  %msg        = new_message_with_text(
                                                   severity = if_abap_behv_message=>severity-error
                                                   text     = 'Vorname darf nicht initial sein' )
                                  %element-firstname = if_abap_behv=>mk-on ) ).
  ENDMETHOD.

  METHOD precheck_create.
    failed-partner = VALUE #( FOR partner IN entities WHERE ( FirstName IS INITIAL AND %control-FirstName = if_abap_behv=>mk-on )
                                ( %cid        = partner-%cid
                                  %is_draft   = partner-%is_draft
                                  uuid        = partner-uuid
                                  %fail-cause = if_abap_behv=>cause-unspecific ) ).
    reported-partner = VALUE #( FOR partner IN entities WHERE ( FirstName IS INITIAL AND %control-FirstName = if_abap_behv=>mk-on )
                                ( %cid        = partner-%cid
                                  %is_draft   = partner-%is_draft
                                  uuid        = partner-uuid
                                  %msg        = new_message_with_text(
                                                   severity = if_abap_behv_message=>severity-error
                                                   text     = 'PRECHECK-CREATE: Vorname darf nicht initial sein' )
                                  %element-firstname = if_abap_behv=>mk-on ) ).
  ENDMETHOD.

  METHOD precheck_update.
    failed-partner = VALUE #( FOR partner IN entities WHERE ( FirstName IS INITIAL AND %control-FirstName = if_abap_behv=>mk-on )
                                ( %tky        = partner-%tky
                                  %fail-cause = if_abap_behv=>cause-unspecific ) ).
    reported-partner = VALUE #( FOR partner IN entities WHERE ( FirstName IS INITIAL AND %control-FirstName = if_abap_behv=>mk-on )
                                ( %tky        = partner-%tky
                                  %msg        = new_message_with_text(
                                                   severity = if_abap_behv_message=>severity-error
                                                   text     = 'PRECHECK: Vorname darf nicht initial sein' )
                                  %element-firstname = if_abap_behv=>mk-on ) ).

  ENDMETHOD.

  METHOD get_instance_features.

    READ ENTITIES OF ZXI_I_PartnerTP IN LOCAL MODE
      ENTITY Partner
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(partners).
    result = VALUE #( FOR partner IN partners ( %tky = partner-%tky
                                                %features-%action-partnerLock   = COND #( WHEN partner-IsLocked = abap_false AND partner-%is_draft = if_abap_behv=>mk-on
                                                                                    THEN if_abap_behv=>fc-o-enabled
                                                                                    ELSE if_abap_behv=>fc-o-disabled )
                                                %features-%action-partnerUnlock = COND #( WHEN partner-IsLocked = abap_true AND partner-%is_draft = if_abap_behv=>mk-on
                                                                                    THEN if_abap_behv=>fc-o-enabled
                                                                                    ELSE if_abap_behv=>fc-o-disabled ) ) ).
  ENDMETHOD.

  METHOD partnerLock.

    READ ENTITIES OF ZXI_I_PartnerTP IN LOCAL MODE
      ENTITY Partner
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(partners).

    DELETE partners WHERE IsLocked = abap_true.

    MODIFY ENTITIES OF ZXI_I_PartnerTP IN LOCAL MODE
      ENTITY Partner
      UPDATE FIELDS ( IsLocked )
      WITH VALUE #( FOR partner IN partners ( %tky     = partner-%tky
                                              IsLocked = abap_true ) )
      FAILED DATA(mod_failed)
      REPORTED DATA(mod_reported)
      MAPPED   DATA(mod_mapped).

    mapped   = CORRESPONDING #( DEEP mod_mapped ).
    failed   = CORRESPONDING #( DEEP mod_failed ).
    reported = CORRESPONDING #( DEEP mod_reported ).

    READ ENTITIES OF ZXI_I_PartnerTP IN LOCAL MODE
      ENTITY Partner
      ALL FIELDS
      WITH CORRESPONDING #( partners )
      RESULT DATA(result_partners).

    result = VALUE #( FOR key IN keys ( %cid_ref = key-%cid_ref
                                        %tky     = key-%tky
                                        %param   = partners[ %tky = key-%tky ] ) ).

  ENDMETHOD.

  METHOD partnerUnlock.

    READ ENTITIES OF ZXI_I_PartnerTP IN LOCAL MODE
      ENTITY Partner
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(partners).

    DELETE partners WHERE IsLocked = abap_false.

    MODIFY ENTITIES OF ZXI_I_PartnerTP IN LOCAL MODE
      ENTITY Partner
      UPDATE FIELDS ( IsLocked )
      WITH VALUE #( FOR partner IN partners ( %tky     = partner-%tky
                                              IsLocked = abap_false ) )
      FAILED DATA(mod_failed)
      REPORTED DATA(mod_reported)
      MAPPED   DATA(mod_mapped).

    mapped   = CORRESPONDING #( DEEP mod_mapped ).
    failed   = CORRESPONDING #( DEEP mod_failed ).
    reported = CORRESPONDING #( DEEP mod_reported ).

    READ ENTITIES OF ZXI_I_PartnerTP IN LOCAL MODE
      ENTITY Partner
      ALL FIELDS
      WITH CORRESPONDING #( partners )
      RESULT DATA(result_partners).

    result = VALUE #( FOR key IN keys ( %cid_ref = key-%cid_ref
                                        %tky     = key-%tky
                                        %param   = partners[ %tky = key-%tky ] ) ).
  ENDMETHOD.

ENDCLASS.
