@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
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
  association [0..*] to ZXI_I_PARTNERROLE as _PartnerRoles  on $projection.Partner = _PartnerRoles.Partner
  association [0..1] to I_AcademicTitle   as _AcademicTitle on $projection.AcademicTitle = _AcademicTitle.AcademicTitle
  association [0..1] to I_FormOfAddress   as _FormOfAddress on $projection.Title = _FormOfAddress.FormOfAddress
{
  key   guid       as Uuid,
        partner    as Partner,
        @EndUserText.label: 'Anrede'
        title      as Title,
        @EndUserText.label: 'Akademischer Titel'
        acad_title as AcademicTitle,
        @Semantics.name.givenName: true
        @EndUserText.label: 'Vorname'
        name_first as FirstName,
        @Semantics.name.familyName: true
        @EndUserText.label: 'Nachname'
        name_last  as LastName,
        @Semantics.systemDateTime.localInstanceLastChangedAt: true
        timestamp  as TimeStamp,
        _PartnerRoles,
        _AcademicTitle,
        _FormOfAddress
}
