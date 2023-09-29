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
define root view entity ZXI_C_PARTNER
  provider contract transactional_query
  as projection on ZXI_I_PartnerTP
{
  key Uuid,
      Partner,
      Title,
      AcademicTitle,
      FirstName,
      LastName,
      IsLocked,
      CreatedAt,
      CreatedBy,
      ChangedAt,
      ChangedBy,
      /* Associations */
      _AcademicTitle,
      _ChangedBy,
      _CreatedBy,
      _FormOfAddress,
      _PartnerRoles : redirected to composition child ZXI_C_PARTNERROLE
}
