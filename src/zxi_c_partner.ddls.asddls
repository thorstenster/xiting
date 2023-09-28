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
define view entity ZXI_C_PARTNER
  as select from ZXI_I_Partner
  association [0..*] to ZXI_C_PARTNERROLE as _PartnerRoles on $projection.Partner = _PartnerRoles.Partner
{
  key Partner,
      Title,
      AcademicTitle,
      FirstName,
      LastName,
      TimeStamp,
      Uuid,
      /* Associations */
      _AcademicTitle,
      _FormOfAddress,
      _PartnerRoles
}
