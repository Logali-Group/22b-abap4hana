@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'First CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zm22_cds_01_gvaler
  with parameters
    p_AirlineCode : s_carr_id
  as select from scarr
{
  key carrid   as Carrid,
      carrname as Carrname,
      currcode as Currcode,
      url      as Url
}
where
  carrid = $parameters.p_AirlineCode;
