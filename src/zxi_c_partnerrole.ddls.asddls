@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Partner Role'
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZXI_C_PARTNERROLE
  as select from ZXI_I_PARTNERROLE
  association [0..1] to ZXI_C_PARTNER as _Partner on $projection.Partner = _Partner.Partner
{
  key Partner,
  key PartnerRole,
      TimeStamp,
      Uuid,
      ParentUuid,
      /* Associations */
      _Partner
}
