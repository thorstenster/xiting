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
  association [1]    to ZXI_I_Partner as _Partner   on $projection.ParentUuid = _Partner.Uuid
  association [0..1] to ZXI_I_User    as _ChangedBy on $projection.ChangedBy = _ChangedBy.UserID
{
  key guid        as Uuid,
      partner     as Partner,
      @EndUserText.label: 'Rolle'
      partnerrole as PartnerRole,
      @ObjectModel.foreignKey.association: '_ChangedBy'
      @Semantics.user.localInstanceLastChangedBy: true
      changed_by  as ChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      timestamp   as TimeStamp,
      parent_guid as ParentUuid,
      _Partner,
      _ChangedBy
}
