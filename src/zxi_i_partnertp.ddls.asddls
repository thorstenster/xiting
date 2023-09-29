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
      IsLocked,
      CreatedAt,
      CreatedBy,
      ChangedAt,
      ChangedBy,
      /* Associations */
      _AcademicTitle,
      _FormOfAddress,
      _PartnerRoles,
      _CreatedBy,
      _ChangedBy
}
