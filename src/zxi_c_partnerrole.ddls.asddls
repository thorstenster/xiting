@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Partner Role'
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZXI_C_PARTNERROLE
  as projection on ZXI_I_PartnerRoleTP
{
  key Uuid,
      PartnerRole,
      CreatedBy,
      CreatedAt,
      ChangedBy,
      ChangedAt,
      ParentUuid,
      /* Associations */
      _ChangedBy,
      _CreatedBy,
      _Partner : redirected to parent ZXI_C_PARTNER
}
