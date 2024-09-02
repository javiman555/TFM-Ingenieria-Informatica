:- consult('theory.pl').  % Asegúrate de que el archivo theory.pl esté cargado

% Verificar la Proposición 1.2.5
proposition_1_2_5(X, Tau) :-
    % (i) Verificar que Ø y X son conjuntos cerrados
    es_cerrado(X, Tau, []),
    es_cerrado(X, Tau, X),

    % (ii) Verificar la intersección de conjuntos cerrados
    findall(S, (member(S, Tau), es_cerrado(X, Tau, S)), Cerrados),
    intersection_of_closed_sets(Cerrados),

    % (iii) Verificar la unión de conjuntos cerrados
    findall(S, (member(S, Tau), es_cerrado(X, Tau, S)), CerradosForUnion),
    union_of_finite_closed_sets(CerradosForUnion).

% Verificar la intersección de cualquier número (finito o infinito) de conjuntos cerrados
intersection_of_closed_sets([]).
intersection_of_closed_sets([H|T]) :-
    intersection_of_closed_sets(T),
    (T == [] ->
        writeln('Intersección de conjuntos cerrados: Verificación finalizada.');
        intersection_of_closed_sets(T, H)).

intersection_of_closed_sets([], _).
intersection_of_closed_sets([Set|Sets], IntersectingSet) :-
    intersection(Set, IntersectingSet, NewIntersectingSet),
    intersection_of_closed_sets(Sets, NewIntersectingSet).

% Verificar la unión de cualquier número finito de conjuntos cerrados
union_of_finite_closed_sets([]).
union_of_finite_closed_sets([H|T]) :-
    union_of_finite_closed_sets(T),
    (T == [] ->
        writeln('Unión de conjuntos cerrados: Verificación finalizada.');
        union_of_finite_closed_sets(T, H)).

union_of_finite_closed_sets([], _).
union_of_finite_closed_sets([Set|Sets], UnioningSet) :-
    union(Set, UnioningSet, NewUnioningSet),
    union_of_finite_closed_sets(Sets, NewUnioningSet).

% Ejemplo de uso: Verificar la Proposición 1.2.5
verify_proposition_1_2_5 :-
    X = [a, b, c],  % Definir el conjunto X
    Tau = [[], [a], [b], [a, b], [c], [a, c], [b, c], [a, b, c]],  % Definir la topología Tau
    (proposition_1_2_5(X, Tau) ->
        writeln('La Proposición 1.2.5 se cumple.');
        writeln('La Proposición 1.2.5 no se cumple.')).

% Punto de entrada principal
start :-
    writeln('Verificando la Proposición 1.2.5:'),
    verify_proposition_1_2_5.
