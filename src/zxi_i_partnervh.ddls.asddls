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
@ObjectModel.semanticKey: [ 'Partner' ]
@ObjectModel.representativeKey: 'Partner'
@ObjectModel.dataCategory: #VALUE_HELP
define view entity ZXI_I_PARTNERVH
  as select from ZXI_I_Partner
{
      @ObjectModel.text.element: [ 'FullName' ]
  key Partner,
      @Consumption.hidden: true
      Title,
      @Consumption.hidden: true
      AcademicTitle,
      ZXI_I_Partner._FormOfAddress._Text[ Language = $session.system_language ].FormOfAddressName,
      ZXI_I_Partner._AcademicTitle._Text[ Language = $session.system_language ].AcademicTitleName,
      @EndUserText.label: 'Vollständiger Name'
      @Semantics.text: true
      concat_with_space(FirstName,LastName,1) as FullName,
      FirstName,
      LastName,
      IsLocked,
      @UI.hidden: true
      Uuid
}
