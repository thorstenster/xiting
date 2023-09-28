CLASS lhc_partnerrole DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS determineRole FOR DETERMINE ON SAVE
      IMPORTING keys FOR PartnerRole~determineRole.

ENDCLASS.

CLASS lhc_partnerrole IMPLEMENTATION.

  METHOD determineRole.
    read entities of ZXI_I_PartnerTP in local mode
      entity PartnerRole
      ALL FIELDS WITH corresponding #( keys )
      result data(roles).
    read entities of ZXI_I_PartnerTP in local mode
      entity PartnerRole BY \_Partner
      ALL FIELDS WITH corresponding #( keys )
      result data(partners).
    modify entities of ZXI_I_PartnerTP in local mode
      entity PartnerRole
      UPDATE fields ( Partner )
      WITH value #( for role in roles ( %tky = role-%tky
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

ENDCLASS.
