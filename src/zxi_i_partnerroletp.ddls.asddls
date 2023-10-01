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
define view entity ZXI_I_PartnerRoleTP
  as select from ZXI_I_PARTNERROLE
  association to parent ZXI_I_PartnerTP as _Partner on $projection.ParentUuid = _Partner.Uuid
{
  key    Uuid,
         PartnerRole,
         CreatedBy,
         CreatedAt,
         ChangedBy,
         ChangedAt,
         ParentUuid,
         /* Associations */
         _Role,
         _Partner,
         _CreatedBy,
         _ChangedBy
}
