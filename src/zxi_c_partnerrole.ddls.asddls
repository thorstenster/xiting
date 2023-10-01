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
//  association [0..1] to ZXI_I_Role as _RoleVH on $projection.PartnerRole = _RoleVH.Role
{
  key Uuid,
      @Consumption.valueHelpDefinition: [{
          entity: {
              name: 'ZXI_I_Role',
              element: 'Role'
          },
          distinctValues: true,
          useForValidation: false
      }]
 //     @ObjectModel.foreignKey.association: '_RoleVH'
      PartnerRole,
      _Role,
      CreatedBy,
      CreatedAt,
      ChangedBy,
      ChangedAt,
      ParentUuid,
      /* Associations */
      _ChangedBy,
      _CreatedBy,
      _Partner : redirected to parent ZXI_C_PARTNER
//      _RoleVH
}
