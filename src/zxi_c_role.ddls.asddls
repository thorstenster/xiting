@Metadata.allowExtensions: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Rolle'
@ObjectModel.dataCategory: #VALUE_HELP
define root view entity ZXI_C_Role
  as select from ZXI_I_Role
  composition [0..*] of ZXI_C_ROLEPARTNER as _RolePartner
{
  key RoleUuid,
      Role,
      RoleDescription,
      Active,
      CreatedBy,
      CreatedAt,
      CreatedAtDate,
      CreatedAtTime,
      ChangedBy,
      ChangedAt,
      ChangedAtDate,
      ChangedAtTime,
      _ChangedBy,
      _CreatedBy,
      _RolePartner
}
