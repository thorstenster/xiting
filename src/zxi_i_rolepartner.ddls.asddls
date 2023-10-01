@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Role Partner'
@Metadata.allowExtensions: true
define view entity ZXI_I_RolePartner
  as select from zxirolepartner
  association        to ZXI_I_Role    as _Role      on $projection.RoleUuid = _Role.RoleUuid
  association [0..1] to ZXI_I_Partner as _Partner   on $projection.PartnerUuid = _Partner.Uuid
  association [0..1] to ZXI_I_User    as _CreatedBy on $projection.CreatedBy = _CreatedBy.UserID
  association [0..1] to ZXI_I_User    as _ChangedBy on $projection.ChangedBy = _ChangedBy.UserID
{
      @EndUserText.label: 'Role Partner UUID'
  key rolepartneruuid as RolePartnerUuid,
      @Consumption.valueHelpDefinition: [{
          entity: {
              name: 'ZXI_I_PARTNERVH',
              element: 'Uuid'
          }
      }]
      @ObjectModel.foreignKey.association: '_Partner'
      @EndUserText.label: 'Partner'
      partneruuid     as PartnerUuid,
      @ObjectModel.foreignKey.association: '_Role'
      @EndUserText.label: 'Rolle UUID'
      roleuuid        as RoleUuid,
      @ObjectModel.foreignKey.association: '_CreatedBy'
      @Semantics.user.createdBy: true
      created_by      as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at      as CreatedAt,
      @ObjectModel.foreignKey.association: '_ChangedBy'
      @Semantics.user.localInstanceLastChangedBy: true
      changed_by      as ChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      changed_at      as ChangedAt,
      _Role,
      _Partner,
      _CreatedBy,
      _ChangedBy
}
