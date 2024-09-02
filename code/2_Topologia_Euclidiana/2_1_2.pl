% Importar el archivo theory.pl para acceder a las definiciones básicas
:- consult('theory.pl').

% Validar que un conjunto está abierto en la topología Euclidiana
es_abierto_euclidiano(S) :-
    forall(member(X, S), existe_intervalo(X, S)).

% Verifica si existe un intervalo abierto (a, b) que contiene X y está contenido en S
existe_intervalo(X, S) :-
    member((A, B), S),
    A < X,
    X < B,
    sub_intervalo(A, B, S).

% Verificar si el intervalo (a, b) está completamente contenido en S
sub_intervalo(A, B, S) :-
    forall(between(A, B, Y), member(Y, S)).

% Validar la topología Euclidiana
es_topologia_euclidiana(R, Tau) :-
    empty_set(Vacio),
    member(Vacio, Tau),          % La topología contiene el conjunto vacío
    member(R, Tau),              % La topología contiene el conjunto total R
    cerrado_bajo_uniones(Tau),   % La topología es cerrada bajo uniones arbitrarias
    cerrado_bajo_intersecciones(Tau). % La topología es cerrada bajo intersecciones finitas

% Verificación de cierre bajo uniones arbitrarias
cerrado_bajo_uniones(Tau) :-
    findall(U, (member(A, Tau), member(B, Tau), union(A, B, U)), Uniones),
    forall(member(U, Uniones), es_abierto_euclidiano(U)).

% Verificación de cierre bajo intersecciones finitas
cerrado_bajo_intersecciones(Tau) :-
    findall(I, (member(A, Tau), member(B, Tau), intersection(A, B, I)), Intersecciones),
    forall(member(I, Intersecciones), es_abierto_euclidiano(I)).

% Ejemplo de uso: Validar la topología Euclidiana sobre un subconjunto R
start :-
    R = [0, 1, 2, 3, 4, 5],  % Ejemplo de un conjunto en R
    Tau = [[], [0], [1, 2], [0, 1, 2, 3], R],  % Ejemplo de topología Euclidiana
    es_topologia_euclidiana(R, Tau),
    write('Tau es una topología Euclidiana válida.').

