Intenté hacer el txt reader lo mejor que pude, pero me encontre con algunos problemas en mi approach...
La idea fue que el código sea lo más genérico posible, para poder pasarle cualquier .txt con un formato similar
y que lo formatee exitosamente... 
Por ahora sí los formatea, pero hay un par de bugs: 
 -Los datos de los insert son todos string, tengo que parsearlos a los tipos de dato correspondientes
 -Intenté hacer que haga los inserts sin hardcodear casi nada, pero el inconveniente es que el primer insert query
 repite el titulo de las columnas, lo cual rompe sql server, obviamente
 
 ![image](https://github.com/user-attachments/assets/ac0d41c8-eaff-437c-85e4-a5956877128c)

 Creo que el programa puede mejorar, pero no pude tenerlo 100% listo para esta iteración
