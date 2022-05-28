*&---------------------------------------------------------------------*
*& Report zm22_01_gvaler
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zm22_01_gvaler.

class lcl_factura definition.

  public section.

    types: begin of ty_factura,
             importe_base type i,
             iva          type i,
           end of ty_factura,
           tt_factura type table of ty_factura.

    methods: add_item  importing is_item type ty_factura,
      add_items importing it_item type tt_factura,
      constructor importing iv_value type char2.

endclass.

class lcl_factura implementation.

  method add_item.

  endmethod.

  method add_items.

  endmethod.

  method constructor.

  endmethod.

endclass.

start-of-selection.

  data go_factura_old type ref to lcl_factura.

  create object go_factura_old
    exporting
      iv_value = 'AB'.

  data go_factura_new_1 type ref to lcl_factura.

  go_factura_new_1 = new #( iv_value = 'AB' ).

  data(go_factura_new_2) = new lcl_factura( 'AD' ).

  go_factura_new_1->add_item( is_item = value #( importe_base = 10 iva = 2 ) ).

  go_factura_new_1->add_items( it_item = value #( ( importe_base = 10 iva = 2 )
                                                  ( importe_base = 20 iva = 2 ) ) ).

  data gt_facturas type lcl_factura=>tt_factura.

  gt_facturas = value #( ( importe_base = 10 iva = 2 )
                         ( importe_base = 20 iva = 2 ) ).

  go_factura_new_1->add_items( gt_facturas ).

  data(gv_xstr) = cl_abap_codepage=>convert_to( source = conv #( sy-uname ) ).
