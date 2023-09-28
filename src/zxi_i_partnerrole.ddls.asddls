@AbapCatalog.viewEnhancementCategory: [#NONE]
@Metadata.allowExtensions: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Partner Role'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZXI_I_PARTNERROLE
  as select from zxipartnerrole
  association [1] to ZXI_I_Partner as _Partner on $projection.ParentUuid = _Partner.Uuid
{
  key guid        as Uuid,
      partner     as Partner,
      @EndUserText.label: 'Rolle'
      partnerrole as PartnerRole,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      timestamp   as TimeStamp,
      parent_guid as ParentUuid,
      _Partner
}
