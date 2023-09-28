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
    MODIFY ENTITIES OF ZXI_I_PartnerTP IN LOCAL MODE
      ENTITY PartnerRole
      UPDATE FIELDS ( Partner )
      WITH VALUE #( FOR role IN roles ( %tky = role-%tky
                                      Partner = partners[ Uuid = role-ParentUuid ]-Partner ) )
      .
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
    RETURN.
    failed-partner = VALUE #( FOR partner IN entities WHERE ( FirstName IS INITIAL )
                                ( %cid        = partner-%cid
                                  %is_draft   = partner-%is_draft
                                  uuid        = partner-uuid
                                  %fail-cause = if_abap_behv=>cause-unspecific ) ).
    reported-partner = VALUE #( FOR partner IN entities WHERE ( FirstName IS INITIAL )
                                ( %cid        = partner-%cid
                                  %is_draft   = partner-%is_draft
                                  uuid        = partner-uuid
                                  %msg        = new_message_with_text(
                                                   severity = if_abap_behv_message=>severity-error
                                                   text     = 'PRECHECK-CREATE: Vorname darf nicht initial sein' )
                                  %element-firstname = if_abap_behv=>mk-on ) ).
  ENDMETHOD.

  METHOD precheck_update.
    RETURN.
    failed-partner = VALUE #( FOR partner IN entities WHERE ( FirstName IS INITIAL )
                                ( %tky        = partner-%tky
                                  %fail-cause = if_abap_behv=>cause-unspecific ) ).
    reported-partner = VALUE #( FOR partner IN entities WHERE ( FirstName IS INITIAL )
                                ( %tky        = partner-%tky
                                  %msg        = new_message_with_text(
                                                   severity = if_abap_behv_message=>severity-error
                                                   text     = 'PRECHECK: Vorname darf nicht initial sein' )
                                  %element-firstname = if_abap_behv=>mk-on ) ).

  ENDMETHOD.

  METHOD partnerLock.
  ENDMETHOD.

ENDCLASS.
