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
@ObjectModel.semanticKey: [ 'Partner' ]
@ObjectModel.dataCategory: #VALUE_HELP
define view entity ZXI_C_ROLEPARTNER
  as select from ZXI_I_RolePartner
  association        to parent ZXI_C_Role as _Role      on $projection.RoleUuid = _Role.RoleUuid
  association [0..1] to ZXI_I_PARTNERVH   as _PartnerVH on $projection.Partner = _PartnerVH.Partner
{
      @Consumption.valueHelpDefinition: [{
          entity: {
              name: 'ZXI_C_ROLEPARTNER',
              element: 'RolePartnerUuid'
          }
      }]
      @EndUserText.label: 'Role Partner Uuid'
  key RolePartnerUuid,
      @EndUserText.label: 'Partner'
      @ObjectModel.foreignKey.association: '_Partner'
      PartnerUuid,
      @ObjectModel.foreignKey.association: '_PartnerVH'
      _Partner.Partner as Partner,
      @Consumption.valueHelpDefinition: [{
          entity: {
              name: 'ZXI_C_Role',
              element: 'RoleUuid'
          }
      }]
      @ObjectModel.foreignKey.association: '_Role'
      RoleUuid,
      CreatedBy,
      CreatedAt,
      ChangedBy,
      ChangedAt,
      /* Associations */
      _ChangedBy,
      _CreatedBy,
      _Partner,
      _PartnerVH,
      _Role

}
