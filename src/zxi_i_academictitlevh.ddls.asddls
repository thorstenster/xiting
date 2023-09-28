@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Akademischer Titel'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZXI_I_AcademicTitleVH
  as select from I_AcademicTitleVH
{
  key AcademicTitle,
      AcademicTitleName,
      /* Associations */
      _Text
}
