@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Rolle'
@Metadata.allowExtensions: true
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.semanticKey: [ 'Role' ]
define view entity ZXI_I_Role
  as select from zxirole
  association [0..*] to ZXI_I_RolePartner as _RolePartner on $projection.RoleUuid = _RolePartner.RoleUuid
  association [0..1] to ZXI_I_User        as _CreatedBy   on $projection.CreatedBy = _CreatedBy.UserID
  association [0..1] to ZXI_I_User        as _ChangedBy   on $projection.ChangedBy = _ChangedBy.UserID
{
  key guid                                                                                               as RoleUuid,
      @ObjectModel.text.element: [ 'RoleDescription' ]
      @EndUserText.label: 'Rolle'
      role                                                                                               as Role,
      @EndUserText.label: 'Beschreibung'
      @Semantics.text: true
      role_description                                                                                   as RoleDescription,
      active                                                                                             as Active,
      @ObjectModel.foreignKey.association: '_CreatedBy'
      @Semantics.user.createdBy: true
      created_by                                                                                         as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at                                                                                         as CreatedAt,
      @Semantics.businessDate.at: true
      @EndUserText.label: 'Angelegt am'
      tstmp_to_dats( cast( created_at as timestamp ) , $session.user_timezone, $session.client, 'NULL' ) as CreatedAtDate,
      @EndUserText.label: 'Angelegt um'
      tstmp_to_tims( cast( created_at as timestamp ) , $session.user_timezone, $session.client, 'NULL' ) as CreatedAtTime,
      @ObjectModel.foreignKey.association: '_ChangedBy'
      @Semantics.user.localInstanceLastChangedBy: true
      changed_by                                                                                         as ChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      changed_at                                                                                         as ChangedAt,
      @Semantics.businessDate.at: true
      @EndUserText.label: 'Geändert am'
      tstmp_to_dats( cast( changed_at as timestamp ) , $session.user_timezone, $session.client, 'NULL' ) as ChangedAtDate,
      @EndUserText.label: 'Geändert um'
      tstmp_to_tims( cast( changed_at as timestamp ) , $session.user_timezone, $session.client, 'NULL' ) as ChangedAtTime,
      _CreatedBy,
      _ChangedBy,
      _RolePartner
}
