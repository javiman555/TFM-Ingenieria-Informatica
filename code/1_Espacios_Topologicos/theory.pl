% 1_Espacios_Topologicos/theory.pl

% Representación de conjuntos
set([]).  % El conjunto vacío
set([_|_]).  % Cualquier lista es un conjunto

% Pertenencia
belongs(X, [X|_]).
belongs(X, [_|T]) :- belongs(X, T).

% Dos conjuntos son iguales si cada elemento de A está en B y viceversa
equal_sets(A, B) :- subset(A, B), subset(B, A).

% Subconjunto: A es un subconjunto de B si todos los elementos de A están en B
subset([], _).
subset([H|T], B) :- belongs(H, B), subset(T, B).

% Definición del conjunto vacío
empty_set([]).

% Intersección de dos conjuntos A y B, resultado en C
intersection([], _, []).
intersection([H|T], B, [H|C]) :- belongs(H, B), intersection(T, B, C).
intersection([H|T], B, C) :- \+ belongs(H, B), intersection(T, B, C).

% Unión de dos conjuntos A y B, resultado en U
union([], B, B).
union([H|T], B, [H|U]) :- \+ belongs(H, B), union(T, B, U).
union([H|T], B, U) :- belongs(H, B), union(T, B, U).

% Subconjuntos de un conjunto
subsets([], []).
subsets([H|T], [H|S]) :- subsets(T, S).
subsets([_|T], S) :- subsets(T, S).

% Definición de una topología en un conjunto X
topology(X, T) :-
    empty_set(V),
    belongs(V, T),      % T debe contener el conjunto vacío
    belongs(X, T),      % T debe contener el conjunto completo X
    closed_under_finite_unions(T),  % T debe ser cerrado bajo uniones finitas
    closed_under_finite_intersections(T). % T debe ser cerrado bajo intersecciones finitas

% Verificación de cierre bajo uniones finitas
closed_under_finite_unions(T) :-
    findall(U, (member(A, T), member(B, T), union(A, B, U)), Unions),
    forall(member(U, Unions), belongs(U, T)).

% Verificación de cierre bajo intersecciones finitas
closed_under_finite_intersections(T) :-
    findall(Int, (member(A, T), member(B, T), intersection(A, B, Int)), Intersections),
    forall(member(Int, Intersections), belongs(Int, T)).

% Generación de números naturales (para otros propósitos)
naturals(0, []).
naturals(N, [N|Nat]) :- N > 0, N1 is N - 1, naturals(N1, Nat).

%1_1_6 Definición de la topología discreta
discrete_topology(X, T) :-
    power_set(X, T).  % La topología discreta es el conjunto potencia de X

% Genera el conjunto potencia de un conjunto dado
power_set([], [[]]).
power_set([H|T], P) :-
    power_set(T, PT),
    findall([H|Sub], member(Sub, PT), PH),
    append(PT, PH, P).


% 1_1_7 Definición de la topología indiscreta
indiscrete_topology(X, T) :-
    empty_set(V),   % Definir el conjunto vacío
    T = [V, X].     % La topología indiscreta contiene solo el conjunto vacío y el conjunto total X


% Definición 1.2.1: Verificar si un conjunto es abierto en una topología
es_abierto(X, Tau, A) :-
    member(A, Tau).  % Un conjunto A es abierto si pertenece a la topología Tau

% Definición 1.2.4: Verificar si un conjunto es cerrado en un espacio topológico
es_cerrado(X, Tau, S) :-
    complement(S, X, Complement),
    es_abierto(X, Tau, Complement).  % Un conjunto S es cerrado si su complemento es abierto

% Complemento de un conjunto S en X
complement(S, X, Complement) :-
    subtract(X, S, Complement).  % El complemento es X \ S

% Definición 1.2.6: de conjuntos abiertos y cerrados
% Verificar si un subconjunto es abierto y cerrado en una topología
abierto_y_cerrado(X, Tau, S) :-
    % Verificar si S es abierto
    es_abierto(X, Tau, S),
    % Verificar si el complemento de S es abierto
    es_cerrado(X, Tau, S).

% Definición 1.3.1: Verificar si una topología es cofinita
cofinita_topology(X, Tau) :-
    % Verificar que todos los conjuntos abiertos en Tau tienen complementos finitos en X
    forall(member(A, Tau), (A = [] ; subset(A, X), finite_complement(A, X))),
    % Verificar que Tau contiene X y el conjunto vacío
    empty_set(V),
    belongs(V, Tau),
    belongs(X, Tau),
    % Verificar que Tau es una topología, es decir, cumple con todas las propiedades topológicas
    topology(X, Tau).

% Verificar si el complemento de un conjunto es finito
finite_complement(S, X) :-
    complement(S, X, Complemento),
    finite_set(Complemento).

% Verificar si un conjunto es finito
finite_set([]).
finite_set([_|T]) :- finite_set(T).

% 1.3.4 Definición de funciones inyectiva, sobreyectiva y biyectiva

% (i) La función f es inyectiva si f(x1) = f(x2) implica x1 = x2
injectiva(F, X) :-
    forall((member(X1, X), member(X2, X), X1 \= X2), \+ (call(F, X1, Y), call(F, X2, Y))).

% (ii) La función f es sobreyectiva si para cada y ∈ Y existe un x ∈ X tal que f(x) = y
sobreyectiva(F, X, Y) :-
    forall(member(Y1, Y), (member(X1, X), call(F, X1, Y1))).

% (iii) La función f es biyectiva si es tanto inyectiva como sobreyectiva
biyectiva(F, X, Y) :-
    injectiva(F, X),
    sobreyectiva(F, X, Y).

% 1.3.5 Definición de función inversa

% La función f tiene una inversa si existe una función g de Y en X tal que
% g(f(x)) = x para toda x ∈ X y f(g(y)) = y para toda y ∈ Y.
% La función g se llama función inversa de f.

% Definición de existencia de función inversa
tiene_inversa(F, G, X, Y) :-
    % Verificar que g(f(x)) = x para toda x ∈ X
    forall(member(X1, X), (call(F, X1, Y1), call(G, Y1, X1))),
    % Verificar que f(g(y)) = y para toda y ∈ Y
    forall(member(Y1, Y), (call(G, Y1, X2), call(F, X2, Y1))).

% Definición 1.3.7: Imagen inversa de un subconjunto
% f es la función, S es el subconjunto de Y, Inversa es la imagen inversa de S bajo f
imagen_inversa(F, S, Inversa) :-
    findall(X, (member(X, X), call(F, X, Y), member(Y, S)), Inversa).


