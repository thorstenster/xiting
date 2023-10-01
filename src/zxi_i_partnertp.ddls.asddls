@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Partner'
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZXI_I_PartnerTP
  as select from ZXI_I_Partner
  composition [0..*] of ZXI_I_PartnerRoleTP as _PartnerRoles
{
  key Uuid,
      Partner,
      Title,
      AcademicTitle,
      FirstName,
      LastName,
      FullName,
      IsLocked,
      CreatedAt,
      CreatedBy,
      ChangedAt,
      @EndUserText.label: 'Angelegt am'
      tstmp_to_dats( cast( CreatedAt as timestamp ) , abap_user_timezone( $session.user, $session.client,'NULL' ),
              $session.client,
              'NULL' ) as CreatedAtDate,
      @EndUserText.label: 'Angelegt um'
      tstmp_to_tims( cast( CreatedAt as timestamp ) , abap_user_timezone( $session.user, $session.client,'NULL' ),
              $session.client,
              'NULL' ) as CreatedAtTime,
      @EndUserText.label: 'Geändert am'
      tstmp_to_dats( cast( ChangedAt as timestamp ) , abap_user_timezone( $session.user, $session.client,'NULL' ),
              $session.client,
              'NULL' ) as ChangedAtDate,
      @EndUserText.label: 'Geändert um'
      tstmp_to_tims( cast( ChangedAt as timestamp ) , abap_user_timezone( $session.user, $session.client,'NULL' ),
              $session.client,
              'NULL' ) as ChangedAtTime,

      ChangedBy,
      /* Associations */
      _AcademicTitle,
      _FormOfAddress,
      _PartnerRoles,
      _CreatedBy,
      _ChangedBy
}
