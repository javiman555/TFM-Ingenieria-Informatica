% Importar el archivo theory.pl para acceder a las definiciones básicas
:- consult('theory.pl').

% Definición de intervalos abiertos
% Representar un intervalo abierto como (A, B) y un conjunto como lista de intervalos
intervalo_abierto(A, B, X) :-
    real(A),
    real(B),
    A < B,
    A < X,
    X < B.

% (i) Si S es la unión de intervalos abiertos, entonces S es un conjunto abierto
es_abierto_si_union_intervalos(S) :-
    % Verificar que S puede ser representado como la unión de intervalos abiertos
    union_de_intervalos(S, Intervalos),
    % Verificar que cada intervalo es abierto
    forall(member((A, B), Intervalos), (forall(member(X, S), intervalo_abierto(A, B, X)))).

% Verificar si un conjunto es la unión de intervalos abiertos
union_de_intervalos(S, Intervalos) :-
    findall((A, B), (member(X, S), intervalo_abierto(A, B, X)), Intervalos),
    % Asegurar que la unión de los intervalos es igual a S
    union_intervalos(Intervalos, UnionS),
    equal_sets(S, UnionS).

% Unir una lista de intervalos abiertos
union_intervalos(Intervalos, UnionS) :-
    flatten(Intervalos, List),
    sort(List, SortedList),
    subtract(SortedList, [], UnionS).

% (ii) Si S es un conjunto abierto, entonces S es la unión de intervalos abiertos
es_union_intervalos_si_abierto(S) :-
    % Verificar que S es abierto
    es_abierto_euclidiano(S),
    % Encontrar intervalos que cubren S
    encontrar_intervalos(S, Intervalos),
    % Verificar que la unión de estos intervalos cubre S
    union_intervalos(Intervalos, UnionS),
    equal_sets(S, UnionS).

% Encontrar una lista de intervalos abiertos que cubren S
encontrar_intervalos(S, Intervalos) :-
    findall((A, B), (member(X, S), intervalo_abierto(A, B, X)), Intervalos).

% Verificar la Proposición 2.2.1
start :-
    S = [0, 0.5, 1, 1.5, 2],  % Un conjunto en esta representación abstracta
    % Verificar la primera parte: unión de intervalos abiertos implica abierto
    (es_abierto_si_union_intervalos(S) -> write('S es abierto porque es la unión de intervalos abiertos.'), nl; write('S no es abierto a pesar de ser la unión de intervalos abiertos.'), nl),
    % Verificar la segunda parte: abierto implica unión de intervalos abiertos
    (es_union_intervalos_si_abierto(S) -> write('S puede escribirse como la unión de intervalos abiertos.'), nl; write('S no puede escribirse como la unión de intervalos abiertos.'), nl).

