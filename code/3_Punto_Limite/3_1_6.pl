% Archivo: proposicion_3_1_6.pl
% Validación de la Proposición 3.1.6 en la que se verifica la relación entre puntos límites y conjuntos cerrados

:- consult('theory.pl').  % Cargar definiciones básicas desde theory.pl

% Definir el espacio topológico (X, Tau) y el subconjunto A
espacio_topologico(X, Tau, A) :-
    X = [a, b, c, d, e],
    Tau = [[a], [c, d], [a, c, d], [b, c, d, e], [a, b, c, d, e], []],
    A = [b, d, e].

% Verificar si un conjunto A es cerrado si y solo si contiene todos sus puntos límites
verificar_proposicion_3_1_6 :-
    espacio_topologico(X, Tau, A),
    (es_cerrado(A, X, Tau) ->
        (contiene_todos_puntos_limite(A, X, Tau) ->
            format('A es cerrado y contiene todos sus puntos límites.~n');
            format('A es cerrado, pero no contiene todos sus puntos límites.~n')
        );
        (contiene_todos_puntos_limite(A, X, Tau) ->
            format('A contiene todos sus puntos límites, pero no es cerrado.~n');
            format('A no es cerrado y no contiene todos sus puntos límites.~n')
        )
    ).

% Predicado que verifica si A es un conjunto cerrado
es_cerrado(A, X, Tau) :-
    complemento(A, X, Complemento),
    es_abierto(Complemento, Tau).

% Predicado que verifica si el conjunto es abierto
es_abierto(Conjunto, Tau) :-
    member(Conjunto, Tau).

% Predicado para calcular el complemento de A en X manualmente
complemento([], X, X).  % Si A es vacío, el complemento es todo X
complemento([H|T], X, Complemento) :-
    select(H, X, XsinH),  % Elimina H de X
    complemento(T, XsinH, Complemento).  % Recurre con el resto de A

% Predicado que verifica si A contiene todos sus puntos límites
contiene_todos_puntos_limite(A, X, Tau) :-
    forall((member(Punto, X), punto_limite(Punto, A, Tau)), member(Punto, A)).

% Ejecución de la validación de la proposición 3.1.6
start:- verificar_proposicion_3_1_6.
