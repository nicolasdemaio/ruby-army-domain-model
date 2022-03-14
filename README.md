# ruby-army-domain-model

## Enunciado - Ejercicio de Webinar POO
*Disclaimer: Este enunciado fue sacado de un Webinar realizado por un youtuber hispano-hablante, lo resolví para practicar Ruby (ya que lo utilicé durante una cursada de 4 meses en la universidad).*

### Ejercicio: Guerra de ejércitos

#### Ejercitos
Los ejércitos poseen una cantidad inicial de piqueros, arqueros y caballeros dependiendo de la civilización.
Tambien, poseen 1000 monedas de oro al momento de la creación.
Cada ejercito posee un historial de todas las batallas en las que participo.

#### Unidades
Hay tres tipos de unidades:
- Piquero: 5 puntos de fuerza
- Arquero: 10 puntos de fuerza
- Caballero: 20 puntos de fuerza

#### Creacion de civilizaciones
El ejercito chino inicia con 2 piqueros, 25 arqueros y 2 caballeros.
El ejercito ingles inicia con 10 piqueros, 10 arqueros y 10 caballeros.
El ejercito bizantino inicia con 5 piqueros, 8 arqueros y 15 caballeros.

#### Entrenamiento
Las unidades se pueden entrenar, costando oro y aumentando la fuerza de la unidad.
- Piquero: cuesta 10 de oro, aumenta 3 puntos
- Arquero: cuesta 20 de oro, aumenta 7 puntos
- Caballero: cuesta 30 de oro, aumenta 10 puntos

#### Transformacion
Las unidades pueden ser entrenadas para transformarse a otra unidad.
- Piquero a Arquero por 30 de oro
- Arquero a Caballero por 40 de oro
- Caballero no pueden transformarse

#### Batallas
Un ejercito puede atacar a otro en cualquier momento, gana el que tenga mas puntos.
El ejercito ganador obtiene 100 monedas de oro.
El ejercito perdedor pierde las dos unidades con mayor puntaje.
En empate, ambos pierden alguna unidad.
