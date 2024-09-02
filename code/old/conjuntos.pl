% Representaci�n de conjuntos
conjunto([]). % El conjunto vac�o
conjunto([_|_]). % Cualquier lista es un conjunto

% Pertenencia
pertenece(X, [X|_]).
pertenece(X, [_|T]) :- pertenece(X, T).

% Dos conjuntos son iguales si todo elemento de A est� en B y viceversa
iguales(A, B) :- subset(A, B), subset(B, A).

% Subconjunto: A es subconjunto de B si todos los elementos de A est�n en B
subset([], _).
subset([H|T], B) :- pertenece(H, B), subset(T, B).

% Definici�n del conjunto vac�o
vacio([]).

% Par de conjuntos
par(A, B, [A, B]).

% Intersecci�n de dos conjuntos A y B, resultado en C
interseccion([], _, []).
interseccion([H|T], B, [H|C]) :- pertenece(H, B), interseccion(T, B, C).
interseccion([H|T], B, C) :- \+ pertenece(H, B), interseccion(T, B, C).

% Uni�n de dos conjuntos A y B, resultado en U
union([], B, B).
union([H|T], B, [H|U]) :- \+ pertenece(H, B), union(T, B, U).
union([H|T], B, U) :- pertenece(H, B), union(T, B, U).


% Subconjuntos de un conjunto
subconjunto([], []).
subconjunto([H|T], [H|S]) :- subconjunto(T, S).
subconjunto([_|T], S) :- subconjunto(T, S).

% Conjunto potencia
potencia(A, P) :- findall(S, subconjunto(A, S), P).


% Definici�n de topolog�a sobre un conjunto X
topologia(X, T) :-
    vacio(V),
    pertenece(V, T),
    pertenece(X, T),
    cerrada_uniones(T),
    cerrada_intersecciones(T).

% Verificaci�n de cerradura bajo uniones
cerrada_uniones(T) :-
    findall(Sub, subset(Sub, T), Subs),
    forall(member(Sub, Subs), (union(Sub, [], U), pertenece(U, T))).

% Verificaci�n de cerradura bajo intersecciones
cerrada_intersecciones(T) :-
    findall(Fin, subset(Fin, T), Fins),
    forall(member(Fin, Fins), (Fin \= [], interseccion(Fin, Int), pertenece(Int, T))).


% Ejemplo de subconjuntos y sus intersecciones
subconjuntos(T, Sub) :- subset(Sub, T).
intersecciones_finitas(T, Int) :- subset(Fin, T), interseccion(Fin, Int).


% Base case: El conjunto vac�o es un conjunto de n�meros naturales.
naturales(0, []).

% Recursive case: Genera una lista de los primeros N n�meros naturales.
naturales(N, [N|Nat]) :- N > 0, N1 is N - 1, naturales(N1, Nat).
