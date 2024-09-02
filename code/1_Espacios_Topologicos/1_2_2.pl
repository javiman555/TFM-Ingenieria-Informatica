% 1_Espacios_Topologicos/proposicion_1_2_2.pl

:- consult('theory.pl').

% (i) Verificar que X y Ø son conjuntos abiertos
son_abiertos_basicos(X, Tau) :-
    empty_set(V),        % Ø (conjunto vacío)
    member(X, Tau),      % X debe estar en Tau
    member(V, Tau).      % Ø debe estar en Tau

% (ii) Verificar que la unión de cualquier par de conjuntos abiertos es un conjunto abierto
% Muestra los pares de conjuntos cuya unión no pertenece a Tau.
union_abiertos(Tau) :-
    forall(
        (member(A, Tau), member(B, Tau), union(A, B, U), sort(U, SortedU), 
         (member(SortedU, Tau) -> true ; format('La unión de ~w y ~w, que es ~w, no está en la topología.\n', [A, B, SortedU]), fail)),
        true
    ).

% sort/2: Ordena la lista de la unión para asegurar que [a,b] y [b,a] se consideren iguales




% Calcula la unión de todos los conjuntos en una lista de subconjuntos
union_all([], []).  % La unión de una lista vacía de conjuntos es el conjunto vacío
union_all([H|T], U) :-
    union_all(T, UT),    % Unión de la cola de la lista
    union(H, UT, U).     % Unión del primer elemento con el resto


% (iii) Verificar que la intersección de cualquier número finito de conjuntos abiertos es un conjunto abierto
% Se verifica si para cada subconjunto finito de Tau, la intersección está en Tau.
interseccion_abiertos(Tau) :-
    forall(subsets(Tau, Sub), (intersection_all(Sub, I), member(I, Tau))).

% Calcula la intersección de todos los conjuntos en una lista
intersection_all([], X) :- empty_set(X).
intersection_all([H|T], I) :-
    intersection_all(T, IT),
    intersection(H, IT, I).

% Verificar toda la proposición 1.2.2
proposition_1_2_2(X, Tau) :-
    son_abiertos_basicos(X, Tau),
    union_abiertos(Tau),
    interseccion_abiertos(Tau).

% Ejemplo de uso: Verificar la Proposición 1.2.2
verify_proposition_1_2_2 :-
    X = [a, b, c],  % Definir el conjunto X
    Tau = [[a], [b], [c], [], [a, b], [a, c], [b, c], [a, b, c]],  % Definir la topología Tau
    (proposition_1_2_2(X, Tau)  ->
        writeln('La Proposición 1.2.2 es verdadera para la topología τ.');
        writeln('La Proposición 1.2.2 es falsa para la topología τ.')).

% Punto de entrada principal
start :-
    writeln('Verificando la Proposición 1.2.2:'),
    verify_proposition_1_2_2.

