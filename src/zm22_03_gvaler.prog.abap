*&---------------------------------------------------------------------*
*& Report zm22_03_gvaler
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zm22_03_gvaler.

select carrid, connid, fldate
      from sflight
      into table @data(gt_flights).

select carrid, connid, fldate
    from sflight
    into table @data(gt_airlines).

data: gt_final type table of sflight,
      gs_final type sflight.

* OLD Model
loop at gt_flights assigning field-symbol(<gs_old_flights>)
        where carrid eq 'LH'.

  loop at gt_airlines into data(gs_old_airlines)
       where connid eq <gs_old_flights>-connid.

    gs_final-carrid = <gs_old_flights>-carrid.
    gs_final-connid = gs_old_airlines-connid.
    append gs_final to gt_final.

  endloop.
endloop.

* New Model

gt_final = value #( for <gs_new_flights> in gt_flights where (  carrid = 'LH')
                        for gs_new_airline in gt_airlines where ( connid = <gs_new_flights>-connid )
                           ( carrid = <gs_new_flights>-carrid
                             connid = gs_new_airline-connid ) ).



types: begin of ty_structure,
         col1 type i,
         col2 type i,
         col3 type i,
       end of ty_structure,
       ty_table type standard table of ty_structure with empty key.

data: gt_table type ty_table,
      gv_index type i.

field-symbols <gs_tab> type ty_structure.

gv_index = 1.

do.

  gv_index = gv_index + 10.
*   gv_index += 10.

  if gv_index > 40.
    exit.
  endif.

  append initial line to gt_table assigning <gs_tab>.
  <gs_tab>-col1 = gv_index.
  <gs_tab>-col2 = gv_index + 1.
  <gs_tab>-col3 = gv_index + 2.

enddo.

data(gt_itab_new) = value ty_table( for i = 11 then i + 10 until i > 40
                                        ( col1 = i
                                          col2 = i + 1
                                          col3 = i + 2 ) ).

write 'OLD'.
loop at gt_table assigning <gs_tab>.
  write: / <gs_tab>-col1, <gs_tab>-col2, <gs_tab>-col3.
endloop.

skip 2.
write 'NEW'.
loop at gt_itab_new assigning <gs_tab>.
  write: / <gs_tab>-col1, <gs_tab>-col2, <gs_tab>-col3.
endloop.
