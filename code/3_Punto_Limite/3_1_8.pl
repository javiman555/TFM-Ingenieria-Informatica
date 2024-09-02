% Archivo: proposicion_3_1_8.pl
% Verificación de la Proposición 3.1.8 sobre conjuntos cerrados y puntos límites

:- consult('theory.pl').  % Cargar definiciones básicas desde theory.pl

% Definir el espacio topológico (X, Tau) y el subconjunto A
espacio_topologico(X, Tau, A) :-
    X = [a, b, c, d, e],
    Tau = [[a], [c, d], [a, c, d], [b, c, d, e], [a, b, c, d, e], []],
    A = [a, b, c].

% Determinar el conjunto de todos los puntos límites A'
conjunto_puntos_limite(A, X, Tau, A_prime) :-
    findall(Punto, (member(Punto, X), punto_limite(Punto, A, Tau)), A_prime).

% Verificar si A ∪ A' es un conjunto cerrado
verificar_proposicion_3_1_8 :-
    espacio_topologico(X, Tau, A),
    conjunto_puntos_limite(A, X, Tau, A_prime),
    union(A, A_prime, Union_A_Aprime),
    (es_cerrado(Union_A_Aprime, X, Tau) ->
        format('A ∪ A′ es un conjunto cerrado.~n');
        format('A ∪ A′ no es un conjunto cerrado.~n')
    ).

% Predicado que verifica si A es un conjunto cerrado
es_cerrado(A, X, Tau) :-
    complemento(A, X, Complemento),
    es_abierto(Complemento, Tau).

% Predicado que verifica si el conjunto es abierto
es_abierto(Conjunto, Tau) :-
    member(Conjunto, Tau).

% Predicado para calcular el complemento de A en X manualmente
complemento([], X, X).
complemento([H|T], X, Complemento) :-
    select(H, X, XsinH),
    complemento(T, XsinH, Complemento).

% Predicado que verifica si un elemento es un punto límite de A
punto_limite(Punto, A, Tau) :-
    \+ member(Punto, A),  % Punto no está en A
    forall((member(U, Tau), member(Punto, U)), 
           (intersection(U, A, Intersec), Intersec \= [], Intersec \= [Punto])).

% Ejecución de la validación de la proposición 3.1.8
start:- verificar_proposicion_3_1_8.
