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
define view entity ZXI_I_PartnerRoleTP
  as select from ZXI_I_PARTNERROLE
  association to parent ZXI_I_PartnerTP as _Partner on $projection.ParentUuid = _Partner.Uuid
{
  key    Uuid,
         Partner,
         PartnerRole,
         ChangedBy,
         TimeStamp,
         ParentUuid,
         /* Associations */
         _Partner,
         _ChangedBy
}
