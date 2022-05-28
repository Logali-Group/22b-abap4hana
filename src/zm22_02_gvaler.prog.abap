*&---------------------------------------------------------------------*
*& Report zm22_02_gvaler
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zm22_02_gvaler.

select carrid, connid, fldate
      from sflight
      into table @data(gt_new_flights).

data(gv_carrid) = 'AA'.

select carrid, connid, fldate
      from sflight
      into table @gt_new_flights
      where carrid eq @gv_carrid.

read table gt_new_flights into data(gs_new_flights) index 1.
gs_new_flights-carrid = 'LH'.

try.

    data(gs_new_flights_2) = gt_new_flights[ 1 ].
    gs_new_flights_2 = gt_new_flights[ carrid = 'AA' connid = '1017' ].

   data(gv_carrid_2) = gt_new_flights[ 3 ]-carrid.

  catch cx_sy_itab_line_not_found into data(gx_itab_not_found).
    write gx_itab_not_found->get_text(  ).
endtry.

append initial line to gt_new_flights assigning field-symbol(<gs_new_flights>).
<gs_new_flights>-carrid = 'JP'.

data: gv_value_1 type f value '10',
      gv_value_2 type f value '1.9'.

data(gv_final) = gv_value_1 + gv_value_2.
