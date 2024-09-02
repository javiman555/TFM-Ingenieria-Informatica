% Consultar el archivo theory.pl
:- consult('../2_Topologia_Euclidiana/theory.pl').



% Definición 3.1.1: Punto límite de un subconjunto en un espacio topológico
% Un punto x es un punto límite de un subconjunto A de un espacio topológico (X, τ)
% si todo conjunto abierto U que contiene x también contiene un punto de A diferente de x.

% Definición del predicado para verificar si un punto es un punto límite
punto_limite(X, A, Tau) :-
    % X es un punto de límite de A si para todo conjunto abierto U que contiene a X,
    % existe un punto Y en U tal que Y es distinto de X y pertenece a A.
    forall((member(U, Tau), member(X, U)),
           (member(Y, U), Y \= X, member(Y, A))).


% Definición 3.1.9: Clausura de un subconjunto
% La clausura de un conjunto A en un espacio topológico (X, Tau) es el conjunto A union A',
% donde A' es el conjunto de todos los puntos límites de A.

% clausura(A, X, Tau, ClausuraA)
% ClausuraA es la clausura del conjunto A en el espacio topológico (X, Tau).
clausura(A, X, Tau, ClausuraA) :-
    conjunto_puntos_limite(A, X, Tau, A_prime),
    union(A, A_prime, ClausuraA).

% conjunto_puntos_limite(A, X, Tau, A_prime)
% A_prime es el conjunto de puntos límites de A en el espacio topológico (X, Tau).
conjunto_puntos_limite(A, X, Tau, A_prime) :-
    findall(P, (member(P, X), es_punto_limite(P, A, Tau)), A_prime).

% es_punto_limite(P, A, Tau)
% Verifica si P es un punto límite de A en la topología Tau.
es_punto_limite(P, A, Tau) :-
    forall(
        (member(U, Tau), member(P, U)),
        (intersection(U, A, Inter), Inter \= [], Inter \= [P])
    ).

% Definición 3.1.13: Un conjunto A es denso en X si la clausura de A es igual a X
denso(A, X, Tau) :-
    clausura(A, X, Tau, ClausuraA),
    ClausuraA = X.



% Definición 3.2.1: Un conjunto N es una vecindad de un punto p si existe un conjunto abierto U tal que p ∈ U ⊆ N.
es_vecindad(N, p, X, Tau) :-
    member(U, Tau),         % Encontrar un conjunto abierto U en la topología Tau
    member(p, U),           % Asegurarse de que p esté en U
    subset(U, N).           % Verificar que U está contenido en N

% Helper: Verificar si un conjunto es un subconjunto de otro
%subset([], _).
%subset([X|Xs], Y) :-
%    member(X, Y),
%    subset(Xs, Y).



% Definición 3.3.4: Verificar si el espacio (X, Tau) es conexo
es_conexo(X, Tau) :-
    % Encontrar todos los subconjuntos de X que son abiertos y cerrados
    findall(Sub, (subset(Sub, X), es_abierto(Sub, Tau), es_cerrado(Sub, X, Tau)), Subconjuntos),
    % Filtrar los subconjuntos no vacíos y no iguales a X
    exclude(==(X), Subconjuntos, Sin_X),
    exclude(==([]), Sin_X, Sin_Vacio),
    % Verificar que no haya subconjuntos no vacíos abiertos y cerrados
    (   Sin_Vacio = []
    -> write('El espacio es conexo.')
    ;   write('El espacio no es conexo.')
    ).


