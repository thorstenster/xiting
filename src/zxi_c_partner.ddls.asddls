@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Partner'
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZXI_C_PARTNER
  provider contract transactional_query
  as projection on ZXI_I_PartnerTP
  association [0..1] to ZXI_I_PARTNERVH as _PartnerVH on $projection.Partner = _PartnerVH.Partner
{
  key Uuid,
      @ObjectModel.foreignKey.association: '_PartnerVH'
      @Consumption.valueHelpDefinition: [{
          entity: {
              name: 'ZXI_I_PartnerVH',
              element: 'Partner'
          },
          distinctValues: true
      }]
      Partner,
      Title,
      AcademicTitle,
      FirstName,
      LastName,
      FullName,
      IsLocked,
      CreatedAt,
      CreatedAtDate,
      CreatedAtTime,
      CreatedBy,
      ChangedAt,
      ChangedAtDate,
      ChangedAtTime,
      ChangedBy,
      /* Associations */
      _AcademicTitle,
      _ChangedBy,
      _CreatedBy,
      _FormOfAddress,
      _PartnerVH,
      _PartnerRoles : redirected to composition child ZXI_C_PARTNERROLE
}
