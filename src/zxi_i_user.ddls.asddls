@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'User'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZXI_I_User
  as select from I_User
{
  key UserID,
      UserDescription,
      IsTechnicalUser,
      AddressPersonID,
      AddressID,
      /* Associations */
      _AddrCurDefaultEmailAddress

}
