use universidad;
# 1 Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. 
# El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
Select apellido1 as Primer_apellido, apellido2 as Segundo_apellido, nombre from persona
where tipo = 'alumno' order by apellido1 asc, apellido2 asc, nombre;

# 2 Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
Select nombre, apellido1, apellido2, telefono from persona
where tipo = 'alumno' and telefono is null;

# 3 Retorna el llistat dels alumnes que van néixer en 1999.
Select nombre, apellido1, apellido2, fecha_nacimiento from persona
where tipo = 'alumno' and year(fecha_nacimiento) = 1999;

# 4 Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades 
# i a més el seu NIF acaba en K.
Select * from persona where tipo = 'profesor' and telefono is null and right(nif, 1) = 'k';
#where right(columna, num de caracter) se usa para encontrar un caracter empezando por el final.

# 5 Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre,
# en el tercer curs del grau que té l'identificador 7.
Select * from asignatura
where cuatrimestre = 1 and curso = 3 and id_grado = 7;

/* 6 Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. 
El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. 
El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.*/
Select apellido1 as primer_apellido, apellido2 as segundo_apellido, persona.nombre, departamento.nombre as nombre_departamento
from persona inner join profesor on id_profesor = persona.id
inner join departamento on departamento.id = profesor.id_departamento
where tipo = 'profesor' order by apellido1 asc, apellido2 asc, persona.nombre asc;

# 7 Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar 
# de l'alumne/a amb NIF 26902806M.
Select asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin, persona.nif from asignatura
inner join alumno_se_matricula_asignatura on id_asignatura = asignatura.id
inner join curso_escolar on curso_escolar.id = id_curso_escolar
inner join persona on persona.id = alumno_se_matricula_asignatura.id_alumno
where persona.nif = '26902806M';

# 8 Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna 
# assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
Select departamento.nombre from departamento
inner join profesor on profesor.id_departamento = departamento.id
inner join asignatura on asignatura.id_profesor= profesor.id_profesor
inner join grado on grado.id = asignatura.id_grado
where grado.nombre = 'Grado en Ingenieria Informática (Plan 2015)' 
group by departamento.nombre;

# 9 Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
Select persona.nombre, apellido1, apellido2, nif from persona
inner join alumno_se_matricula_asignatura on alumno_se_matricula_asignatura.id_alumno = persona.id
inner join curso_escolar on curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar
where persona.tipo = 'alumno' and curso_escolar.anyo_inicio = '2018' and curso_escolar.anyo_fin = '2019'
group by persona.nombre, apellido1, apellido2, nif;

# Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

# 10(1) Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. 
# El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. 
# El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. 
# El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom. 
Select departamento.nombre as nombreDepartamento, apellido1 as primerApellido, apellido2 as segundoApellido, persona.nombre as nombreProfesor from persona
left join profesor on persona.id = profesor.id_profesor
left join departamento on profesor.id_departamento = departamento.id
where persona.tipo = "profesor" 
order by departamento.nombre, apellido1, apellido2, persona.nombre;

# 11(2) Retorna un llistat amb els professors/es que no estan associats a un departament.
Select persona.nombre from persona
left join profesor on persona.id = profesor.id_profesor
where persona.tipo = "profesor" and profesor.id_departamento is null;

# 12(3) Retorna un llistat amb els departaments que no tenen professors/es associats.
Select departamento.nombre from departamento 
left join profesor on departamento.id = profesor.id_departamento 
WHERE profesor.id_profesor IS NULL;

# 13(4) Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
Select persona.nombre, apellido1, apellido2 from persona
left join asignatura on asignatura.id_profesor = persona.id
where persona.tipo = "profesor" and asignatura.id_profesor is null;

# 14(5) Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
Select asignatura.nombre from profesor
right join asignatura on profesor.id_profesor = asignatura.id_profesor
where asignatura.id_profesor is null; 

# 15(6) Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
Select departamento.nombre from departamento
left join profesor on departamento.id = profesor.id_departamento
left join asignatura on profesor.id_profesor = asignatura.id_profesor
where curso is null;

# 16(1)Retorna el nombre total d'alumnes que hi ha.
Select COUNT(*) as total_alumnos from persona
where tipo = "alumno";

# 17(2) Calcula quants alumnes van néixer en 1999.
Select Count(*) from persona
where tipo = "alumno" and YEAR(fecha_nacimiento) = 1999;

#18(3) Calcula quants professors/es hi ha en cada departament. 
#El resultat només ha de mostrar dues columnes, una amb el nom del departament 
#i una altra amb el nombre de professors/es que hi ha en aquest departament. 
#El resultat només ha d'incloure els departaments que tenen professors/es associats 
#i haurà d'estar ordenat de major a menor pel nombre de professors/es.
Select departamento.nombre as nombreDepartamento, count(id_departamento) as totalProfesores from departamento
right join profesor on profesor.id_departamento = departamento.id
group by departamento.nombre order by totalProfesores desc;


#19(4)Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. 
#Tingui en compte que poden existir departaments que no tenen professors/es associats. 
#Aquests departaments també han d'aparèixer en el llistat.
Select departamento.nombre as nombreDepartamento, count(id_departamento) as totalProfesores from departamento
left join profesor on profesor.id_departamento = departamento.id
group by departamento.nombre;

#20(5) Retorna un llistat amb el nom de tots els graus existents en la base de dades 
#i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus 
#que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. 
#El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
Select grado.nombre, count(asignatura.id_grado) as totalAsignaturas from grado
left join asignatura on grado.id = asignatura.id_grado
group by grado.nombre order by totalAsignaturas desc;

#21(6)Retorna un llistat amb el nom de tots els graus existents en la base de dades 
#i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
Select grado.nombre, count(asignatura.id_grado) as totalAsignaturas from grado
left join asignatura on grado.id = asignatura.id_grado
group by grado.nombre 
having count(asignatura.id_grado) > 40;

#22(7)Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits 
#que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, 
#tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
Select grado.nombre as nombreGrado, asignatura.tipo as tipoAsignatura, SUM(asignatura.creditos) as totalCreditos
from grado inner join asignatura on grado.id = asignatura.id_grado
group by nombreGrado, tipoAsignatura;

#23(8) Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. 
#El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.
Select curso_escolar.anyo_inicio, count(distinct(alumno_se_matricula_asignatura.id_alumno)) as totalAlumnos from curso_escolar
inner join alumno_se_matricula_asignatura on curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar
group by curso_escolar.anyo_inicio; -- DISTINCT SE USA PARA EVITAR DUPLICADOS!

#24(9) Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. 
#El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. 
#El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. 
#El resultat estarà ordenat de major a menor pel nombre d'assignatures.
Select persona.id, persona.nombre, persona.apellido1, persona.apellido2, count(asignatura.id_profesor) as totalAsig from persona
inner join profesor on persona.id = profesor.id_profesor
left join asignatura on profesor.id_profesor = asignatura.id_profesor
group by persona.id order by totalAsig desc;

#25(10) Retorna totes les dades de l'alumne/a més jove.
Select * from persona
where fecha_nacimiento = (select max(fecha_nacimiento) from persona where tipo = 'alumno');
-- max: fecha más próxima, fecha mayor por tanto más joven

#26(11) Retorna un llistat amb els professors/es que tenen un departament associat 
# i que no imparteixen cap assignatura.
Select persona.id, persona.nombre as nombreProfesor, departamento.nombre as nombreDepartamento from persona
inner join profesor on persona.id = profesor.id_profesor
inner join departamento on profesor.id_departamento = departamento.id
left join asignatura on profesor.id_profesor = asignatura.id_profesor
where asignatura.nombre is null;



