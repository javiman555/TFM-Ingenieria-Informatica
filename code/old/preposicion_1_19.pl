% Definici�n de un conjunto unitario (singleton)
unitario(X, [X]).

% Verifica si todos los conjuntos unitarios {x} est�n en Tau
todos_los_unitarios_en_tau([], _).
todos_los_unitarios_en_tau([X|Xs], Tau) :-
    unitario(X, U),
    member(U, Tau),
    todos_los_unitarios_en_tau(Xs, Tau).

% Define mi_subset/2 para verificar si un conjunto es un subconjunto de otro
mi_subset([], _).
mi_subset([E|Rest], Set) :-
    member(E, Set),
    mi_subset(Rest, Set).

% Expresa un conjunto S como la uni�n de sus unitarios {x}
es_union_de_unitarios(S, X, Tau) :-
    mi_subset(S, X), % S es un subconjunto de X
    todos_los_unitarios_en_tau(S, Tau). % Verifica si todos los unitarios de S est�n en Tau

% Demostraci�n de que Tau es la topolog�a discreta
es_topologia_discreta(X, Tau) :-
    % Tau contiene todos los conjuntos unitarios {x}
    forall(member(E, X), (unitario(E, U), member(U, Tau))),
    % Cualquier subconjunto S de X debe estar en Tau
    forall(mi_subset(S, X), es_union_de_unitarios(S, X, Tau)).

% A�ade la consulta aqu�
:- es_topologia_discreta([a], [[], [a], [b], [a,b]]).

