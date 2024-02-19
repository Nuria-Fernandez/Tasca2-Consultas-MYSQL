use tienda;
# 1 Llista el nom de tots els productes que hi ha en la taula producto.
select nombre from producto;

# 2 Llista els noms i els preus de tots els productes de la taula producto
select nombre, precio from producto;

# 3 Llista totes les columnes de la taula producto.
select * from producto;

# 4 Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD)
select nombre, CONCAT(precio, ' €') AS precioEuro, CONCAT(ROUND(precio * 1.08, 2), ' $') AS precioDolar from producto;
#Se usa CONCAT para concatenar STRINGS y se usa ROUND para redondear: ROUND(X, Y)--> X: num a redondear Y: decimales que quieres que aparezcan

# 5 Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD). 
#Utilitza els següents àlies per a les columnes: nom de producto, euros, dòlars.
select nombre AS nombre_de_producto, CONCAT(precio, ' €') AS euros, CONCAT(ROUND(precio * 1.08, 2), ' $') AS dolar from producto;

# 6 Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a majúscula.
Select UPPER(nombre), precio from producto;

# 7 Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a minúscula.
Select LOWER(nombre), precio from producto;

# 8 Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui 
#   en majúscules els dos primers caràcters del nom del fabricant.
Select nombre, UPPER(SUBSTRING(nombre, 1, 2)) AS primeros_dos_caracteres FROM fabricante;

# 9 Llista els noms i els preus de tots els productes de la taula producto, arrodonint el valor del preu.
Select nombre, round(precio) from producto; #round asecas redondea al alza si es mas de .5 y si es menor de .5 va al entero anterior

# 10 Llista els noms i els preus de tots els productes de la taula producto, 
# truncant el valor del preu per a mostrar-lo sense cap xifra decimal.
Select nombre, truncate(precio, 0) from producto;

# 11 Llista el codi dels fabricants que tenen productes en la taula producto.
Select codigo_fabricante from producto;

# 12 Llista el codi dels fabricants que tenen productes en la taula producto, eliminant els codis que apareixen repetits.
Select distinct codigo_fabricante from producto;

# 13 Llista els noms dels fabricants ordenats de manera ascendent.
Select nombre from fabricante order by nombre ASC; -- PODEMOS OBVIAR EL ASC PORQUE POR DEFECTO LO ORDENA ALFABÉTICAMENTE

# 14 Llista els noms dels fabricants ordenats de manera descendent.
Select nombre from fabricante order by nombre desc;

# 15 Llista els noms dels productes ordenats, en primer lloc, pel nom de manera ascendent i, 
# en segon lloc, pel preu de manera descendent.
Select nombre, precio from producto order by nombre asc, precio desc;

# 16 Retorna una llista amb les 5 primeres files de la taula fabricante.
Select * from fabricante limit 5;

# 17 Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante. 
# La quarta fila també s'ha d'incloure en la resposta.
Select * from fabricante limit 3, 2; #El 3 es el desplazamiento u OFFSET desde el que empieza a contar. 
# El conteo del índice va como en los arrayList: empieza en 0. El 2 signidica el num de lineas a devolver.

# 18 Llista el nom i el preu del producte més barat. 
#(Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MIN(preu), necessitaria GROUP BY.
Select nombre, precio from producto order by precio limit 1; #Se ordena por precio de manera asc(de menos a mayor) y le digo que me devuelva la fila 1.

# 19 Llista el nom i el preu del producte més car. 
#(Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MAX(preu), necessitaria GROUP BY.
Select nombre, precio from producto order by precio desc limit 1;

# 20 Llista el nom de tots els productes del fabricant el codi de fabricant del qual és igual a 2.
Select nombre from producto
where codigo_fabricante = 2;

# 21 Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades.
Select producto.nombre, producto.precio, fabricante.nombre from producto
inner join fabricante on fabricante.codigo = codigo_fabricante;

# 22 Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. 
# Ordena el resultat pel nom del fabricant, per ordre alfabètic.
Select producto.nombre, producto.precio, fabricante.nombre from producto
inner join fabricante on fabricante.codigo = codigo_fabricante
order by fabricante.nombre;

# 23 Retorna una llista amb el codi del producte, nom del producte, codi del fabricador i nom del fabricador, 
# de tots els productes de la base de dades.
Select producto.codigo as codigoProducto, producto.nombre as nombreProducto, producto.precio, 
fabricante.codigo as codigoFabrcante, fabricante.nombre as nombreFabricante from producto
inner join fabricante on fabricante.codigo = codigo_fabricante;

# 24 Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat.
Select producto.nombre as nombreProducto, precio, fabricante.nombre as nombreFabricante from producto
inner join fabricante on fabricante.codigo = producto.codigo_fabricante
order by precio limit 1;

# 25 Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car.
Select producto.nombre as nombreProducto, producto.precio, fabricante.nombre as nombreFabricante from producto
inner join fabricante on producto.codigo_fabricante = fabricante.codigo
order by precio desc limit 1;

# 26 Retorna una llista de tots els productes del fabricant Lenovo.
Select producto.codigo, producto.nombre, fabricante.nombre from producto
inner join fabricante on producto.codigo_fabricante = fabricante.codigo
where fabricante.nombre = 'lenovo';

# 27 Retorna una llista de tots els productes del fabricant Crucial que tinguin un preu major que 200 €.
Select producto.codigo, producto.nombre, fabricante.nombre from producto
inner join fabricante on producto.codigo_fabricante = fabricante.codigo
where fabricante.nombre = 'crucial' and producto.precio > 200;

# 28 Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate. 
# Sense utilitzar l'operador IN.
Select producto.codigo, producto.nombre, fabricante.nombre from producto
inner join fabricante on producto.codigo_fabricante = fabricante.codigo
where fabricante.nombre = 'Asus' or fabricante.nombre = 'Hewlett-Packard' or fabricante.nombre = 'Seagate';

#29 Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate. Fent servir l'operador IN.
Select producto.codigo, producto.nombre, fabricante.nombre from producto
inner join fabricante on producto.codigo_fabricante = fabricante.codigo
where fabricante.nombre IN ( 'Asus', 'Hewlett-Packard', 'Seagate');

#30 Retorna un llistat amb el nom i el preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e.
Select  producto.nombre as nombreProducto, producto.precio, fabricante.nombre as nombreFabricante from producto
inner join fabricante on producto.codigo_fabricante = fabricante.codigo
where fabricante.nombre like '%e';

#31 Retorna un llistat amb el nom i el preu de tots els productes el nom de fabricant dels quals contingui el caràcter w en el seu nom.
Select  producto.nombre as nombreProducto, producto.precio, fabricante.nombre as nombreFabricante from producto
inner join fabricante on producto.codigo_fabricante = fabricante.codigo
where fabricante.nombre like '%w%';