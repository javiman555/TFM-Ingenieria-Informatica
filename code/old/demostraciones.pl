% demostraciones.pl

:- consult('conjuntos.pl'). % Cargar el fichero de conjuntos

% Regla para verificar que la uni�n de un conjunto con el vac�o es el propio conjunto
union_con_vacio_es_conjunto(A) :- vacio(V), union(A, V, A), writeln('Union con vacio verificada').

% Regla para verificar que la intersecci�n de un conjunto con el vac�o es el vac�o
interseccion_con_vacio_es_vacio(A) :- vacio(V), interseccion(A, V, V), writeln('Interseccion con vacio verificada').

% Regla para verificar que un conjunto es subconjunto de su conjunto potencia
conjunto_en_potencia(A, P) :- potencia(A, P), forall(subconjunto(A, S), pertenece(S, P)), writeln('Conjunto en potencia verificado').

% Verificaci�n de que una topolog�a incluye el conjunto vac�o y el conjunto total
topologia_incluye_vacio_y_total(X, T) :-
    writeln('Verificando topolog�a...'),
    vacio(V),
    pertenece(V, T),
    writeln('El vac�o pertenece a la topolog�a.'),
    pertenece(X, T),
    writeln('El conjunto total pertenece a la topolog�a.').

% Demostraci�n de propiedades con ejemplos:
probar_demostraciones :-
    naturales(3, Nat), % Generar conjunto {0, 1, 2, 3}
    writeln('Conjunto de n�meros naturales generado: '), writeln(Nat),
    union_con_vacio_es_conjunto(Nat),
    interseccion_con_vacio_es_vacio(Nat),
    conjunto_en_potencia(Nat, P),
    writeln('Conjunto potencia: '), writeln(P),
    topologia_incluye_vacio_y_total(Nat, P),
    writeln('Todas las propiedades verificadas correctamente.').

