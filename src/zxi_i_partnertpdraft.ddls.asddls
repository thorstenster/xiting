@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Partner'
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZXI_I_PARTNERTPDRAFT
  as select from ZXI_I_Partner
  composition [0..*] of ZXI_I_PARTNERROLETPDRAFT as _PartnerRoles
{
  key Uuid,
      Partner,
      Title,
      AcademicTitle,
      FirstName,
      LastName,
      TimeStamp,
      /* Associations */
      _AcademicTitle,
      _FormOfAddress,
      _PartnerRoles
}
