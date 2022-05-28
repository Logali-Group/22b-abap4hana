*&---------------------------------------------------------------------*
*& Report zm22_05_gvaler
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zm22_05_gvaler.

parameters: pa_page type i,
            pa_reg  type i.

data gv_offset type int8.

gv_offset = ( pa_page - 1 ) * pa_reg.

select from sflight
       fields *
       where carrid eq 'AA'
       order by carrid, connid, fldate ascending
       into table @data(gt_result)
       offset @gv_offset
       up to @pa_reg rows.

if sy-subrc eq 0.
  cl_demo_output=>display( gt_result ).
endif.
