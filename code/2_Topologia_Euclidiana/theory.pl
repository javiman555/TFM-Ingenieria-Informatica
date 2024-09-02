% Consultar el archivo theory.pl
:- consult('../1_Espacios_Topologicos/theory.pl').

% Definir una propiedad básica de los números reales
real(X) :- number(X).

% Definir un intervalo abierto (a, b)
intervalo_abierto(A, B, X) :-
    real(A),
    real(B),
    A < B,
    A < X,
    X < B.

% Definición de un conjunto S como abierto en la topología Euclidiana
es_abierto_euclidiano(S) :-
    forall(member(X, S), existe_intervalo(X, S)).

% Verifica si existe un intervalo abierto (a, b) que contiene X y está contenido en S
existe_intervalo(X, S) :-
    real(X),
    member((A,B), S),
    intervalo_abierto(A, B, X),
    forall(member(Y, S), (A =< Y, Y =< B)).

% 2.1.1 Definición: Abierto en la topología Euclidiana sobre R
% Verificar si un subconjunto S de R es abierto en la topología Euclidiana
es_abierto_euclidiano(S) :-
    forall(
        member(X, S),
        (
            % Verificar si existe un intervalo (a, b) tal que X está en (a, b) y (a, b) está contenido en S
            intervalo_contiene(X, S)
        )
    ).

% Verificar si existe un intervalo (a, b) tal que X está en (a, b) y (a, b) está contenido en S
intervalo_contiene(X, S) :-
    % Buscar valores de a y b tales que a < X < b y (a, b) está contenido en S
    member(A, S),
    member(B, S),
    A < X,
    X < B,
    sub_intervalo(A, B, S).

% Verificar si el intervalo (a, b) está completamente contenido en S
sub_intervalo(A, B, S) :-
    forall(
        (between(A, B, Y), Y \= A, Y \= B),
        member(Y, S)
    ).

% Definición 2.2.2: Base de una topología

% Definir una base B para una topología Tau en un conjunto X
base_de_topologia(X, Tau, B) :-
    % Cada conjunto en la topología Tau debe ser una unión de conjuntos en B
    forall(member(OpenSet, Tau), 
        (es_union_de_base(OpenSet, B))
    ).

% Verificar si un conjunto abierto es una unión de miembros de una base B
es_union_de_base(OpenSet, B) :-
    % Encontrar todos los conjuntos en B que cubren OpenSet
    findall(BSet, (member(BSet, B), subset(BSet, OpenSet)), Subsets),
    % Verificar que la unión de estos conjuntos cubre OpenSet
    union_de_base(Subsets, Union),
    equal_sets(OpenSet, Union).

% Unir una lista de conjuntos abiertos de la base B
union_de_base([], []).
union_de_base([H|T], Union) :-
    union_de_base(T, PartialUnion),
    union(H, PartialUnion, Union).
