@AbapCatalog.viewEnhancementCategory: [#NONE]
@Metadata.allowExtensions: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Partner Role'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZXI_I_PARTNERROLE
  as select from zxipartnerrole
  association [1]    to ZXI_I_Partner as _Partner   on $projection.ParentUuid = _Partner.Uuid
  association [0..1] to ZXI_I_User    as _ChangedBy on $projection.ChangedBy = _ChangedBy.UserID
  association [0..1] to ZXI_I_User    as _CreatedBy on $projection.CreatedBy = _CreatedBy.UserID
{
  key guid        as Uuid,
      @EndUserText.label: 'Rolle'
      partnerrole as PartnerRole,
      @Semantics.systemDateTime.createdAt: true
      created_at  as CreatedAt,
      @ObjectModel.foreignKey.association: '_CreatedBy'
      @Semantics.user.createdBy: true
      created_by  as CreatedBy,
      @ObjectModel.foreignKey.association: '_ChangedBy'
      @Semantics.user.localInstanceLastChangedBy: true
      changed_by  as ChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      changed_at  as ChangedAt,
      @EndUserText.label: 'Partner UUID'
      parent_guid as ParentUuid,
      _Partner,
      _CreatedBy,
      _ChangedBy
}
