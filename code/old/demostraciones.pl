% demostraciones.pl

:- consult('conjuntos.pl'). % Cargar el fichero de conjuntos

% Regla para verificar que la unión de un conjunto con el vacío es el propio conjunto
union_con_vacio_es_conjunto(A) :- vacio(V), union(A, V, A), writeln('Union con vacio verificada').

% Regla para verificar que la intersección de un conjunto con el vacío es el vacío
interseccion_con_vacio_es_vacio(A) :- vacio(V), interseccion(A, V, V), writeln('Interseccion con vacio verificada').

% Regla para verificar que un conjunto es subconjunto de su conjunto potencia
conjunto_en_potencia(A, P) :- potencia(A, P), forall(subconjunto(A, S), pertenece(S, P)), writeln('Conjunto en potencia verificado').

% Verificación de que una topología incluye el conjunto vacío y el conjunto total
topologia_incluye_vacio_y_total(X, T) :-
    writeln('Verificando topología...'),
    vacio(V),
    pertenece(V, T),
    writeln('El vacío pertenece a la topología.'),
    pertenece(X, T),
    writeln('El conjunto total pertenece a la topología.').

% Demostración de propiedades con ejemplos:
probar_demostraciones :-
    naturales(3, Nat), % Generar conjunto {0, 1, 2, 3}
    writeln('Conjunto de números naturales generado: '), writeln(Nat),
    union_con_vacio_es_conjunto(Nat),
    interseccion_con_vacio_es_vacio(Nat),
    conjunto_en_potencia(Nat, P),
    writeln('Conjunto potencia: '), writeln(P),
    topologia_incluye_vacio_y_total(Nat, P),
    writeln('Todas las propiedades verificadas correctamente.').

