% 1_Espacios_Topologicos/proposicion_1_1_9.pl

:- consult('theory.pl').

% Verificación de la Proposición 1.1.9
proposition_1_1_9(X, Tau) :-
    power_set(X, DiscreteTau),  % Generar la topología discreta
    forall(member(A, DiscreteTau), member(A, Tau)).  % Verificar que Tau contiene todos los subconjuntos de X

% Ejemplo de uso: Verificar la Proposición 1.1.9
verify_proposition_1_1_9:-
    X = [a, b, c],  % Definir el conjunto X
    Tau = [[a], [b], [c], [], [a, b], [a, c], [b, c], [a, b, c]],  % Definir la topología Tau
    (proposition_1_1_9(X, Tau) ->
        writeln('τ es la topología discreta.');
        writeln('τ no es la topología discreta.')).

% Punto de entrada principal
start :-
    writeln('Verificando la Proposición 1.1.9:'),
    verify_proposition_1_1_9.
