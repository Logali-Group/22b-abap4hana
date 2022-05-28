*&---------------------------------------------------------------------*
*& Report zm22_04_gvaler
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zm22_04_gvaler.

types: begin of ty_empleado,
         nombre   type char30,
         posicion type char30,
         edad     type i,
      end of ty_empleado,
      tt_empleado type standard table of ty_empleado with key nombre.


data(gt_empleados) = value tt_empleado( ( nombre = 'Oscar'  posicion = 'ABAP'      edad = 34 )
                                        ( nombre = 'Carlos' posicion = 'FUNCIONAL' edad = 26 )
                                        ( nombre = 'Adolfo' posicion = 'ABAP'      edad = 32 )
                                        ( nombre = 'Erick'  posicion = 'FUNCIONAL' edad = 37 )
                                        ( nombre = 'Samuel' posicion = 'ABAP'      edad = 29 )
                                        ( nombre = 'Jimmy'  posicion = 'BASIS'     edad = 24 ) ).

data: gv_edad_tot type i,
      gv_edad_avg type i.

loop at gt_empleados into data(gs_employee)
     group by ( posicion =  gs_employee-posicion
                size     = group size
                index    = group index )
     ascending
     assigning field-symbol(<group>).

   clear gv_edad_tot.
*   Salida a nivel de posición
   write: / |Group: { <group>-index } Posción: { <group>-posicion width = 10 }|
            & |Número de empleados de esta posición: { <group>-size }|.

*   Miembros del grupo
    loop at group <group> assigning field-symbol(<gs_miembro>).
       gv_edad_tot += <gs_miembro>-edad.
       write: /20 <gs_miembro>-nombre.
    endloop.

*   Edad del grupo
    gv_edad_avg = gv_edad_tot / <group>-size.
    write: / |Edad media: { gv_edad_avg }|.

endloop.
