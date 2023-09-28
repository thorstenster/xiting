@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Partner'
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZXI_I_Partner
  as select from zxipartner
  association [0..*] to ZXI_I_PARTNERROLE     as _PartnerRoles  on $projection.Partner = _PartnerRoles.Partner
  association [0..1] to ZXI_I_AcademicTitleVH as _AcademicTitle on $projection.AcademicTitle = _AcademicTitle.AcademicTitle
  association [0..1] to ZXI_I_FormOfAddressVH as _FormOfAddress on $projection.Title = _FormOfAddress.FormOfAddress
  association [0..1] to ZXI_I_User            as _ChangedBy     on $projection.ChangedBy = _ChangedBy.UserID
{
  key   guid       as Uuid,
        partner    as Partner,
        @ObjectModel.foreignKey.association: '_FormOfAddress'
        @Consumption.valueHelpDefinition: [{
            entity: {
                name: 'ZXI_I_FormOfAddressVH',
                element: 'FormOfAddress'
            },
            distinctValues: true,
            useForValidation: true
        }]
        @EndUserText.label: 'Anrede'
        title      as Title,
        @Consumption.valueHelpDefinition: [{
            entity: {
                name: 'ZXI_I_AcademicTitleVH',
                element: 'AcademicTitle'
            },
            distinctValues: true,
            useForValidation: true
        }]
        @ObjectModel.foreignKey.association: '_AcademicTitle'
        @EndUserText.label: 'Akademischer Titel'
        acad_title as AcademicTitle,
        @Semantics.name.givenName: true
        @EndUserText.label: 'Vorname'
        name_first as FirstName,
        @Semantics.name.familyName: true
        @EndUserText.label: 'Nachname'
        name_last  as LastName,
        @Semantics.user.localInstanceLastChangedBy: true
        @ObjectModel.foreignKey.association: '_ChangedBy'
        changed_by as ChangedBy,
        @Semantics.systemDateTime.localInstanceLastChangedAt: true
        timestamp  as TimeStamp,
        _PartnerRoles,
        _AcademicTitle,
        _FormOfAddress,
        _ChangedBy
}
