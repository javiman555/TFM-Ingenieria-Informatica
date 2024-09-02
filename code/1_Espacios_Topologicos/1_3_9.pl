:- consult('theory.pl').

% Definición 1.3.9: Verificar si τ1 es una topología sobre X
verificar_topologia_1_3_9(X, Y, F, Tau, Tau1) :-
    % (i) Verificar que Ø y X están en τ1
    member([], Tau1),
    member(X, Tau1),

    % (ii) Verificar cierre bajo uniones arbitrarias
    forall(member(S, Tau), 
        (findall(FInv, (member(S, Tau), imagen_inversa(F, S, FInv)), Tau1),
         union_all_sets(Tau1, Union),
         subset(Union, Tau1))
    ),

    % (iii) Verificar cierre bajo intersecciones finitas
    findall(Intersection, (subset(Finite, Tau1), intersection_all(Finite, Intersection)), Intersections),
    forall(member(Int, Intersections), member(Int, Tau1)).

% Unión de todos los subconjuntos en una lista
union_all_sets([], []).
union_all_sets([H|T], U) :-
    union_all_sets(T, UT),
    union(H, UT, U).

% Intersección de todos los subconjuntos en una lista
intersection_all([], []).
intersection_all([H|T], Int) :-
    intersection_all(T, IntRest),
    intersection(H, IntRest, Int).

% Ejemplo de uso: Verificar si τ1 es una topología sobre X
verificar_ejemplo_1_3_9 :-
    X = [a, b, c],
    Y = [a, b, c, d],
    % Define la función f de X a Y
    F = functor(_, [a, b, c, d], _), % Define según sea necesario

    % Define la topología Tau sobre Y
    Tau = [[], [a], [b], [c], [a, b], [a, c], [b, c], [a, b, c]],

    % Obtener τ1
    findall(FInv, (member(S, Tau), imagen_inversa(F, S, FInv)), Tau1),
    
    (verificar_topologia_1_3_9(X, Y, F, Tau, Tau1) ->
        writeln('τ1 es una topología sobre X.');
        writeln('τ1 no es una topología sobre X.')).

% Punto de entrada principal
start :-
    writeln('Verificando el Ejemplo 1.3.9:'),
    verificar_ejemplo_1_3_9.
