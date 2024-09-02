% 1_Espacios_Topologicos/1_1_8.pl

:- [theory].  % Importa el archivo theory.pl

% Verificación de la topología discreta
verify_discrete_topology(X, Tau) :-
    power_set(X, DiscreteTau),  % Generar la topología discreta
    subset(DiscreteTau, Tau).    % Verificar que la topología dada es la topología discreta

% Verificación del Ejemplo 1.1.8
verify_example_1_1_8 :-
    X = [a, b, c],  % Definir el conjunto X
    Tau = [[a], [b], [c], [], [a, b], [a, c], [b, c], [a, b, c]],  % Definir la topología Tau
    verify_discrete_topology(X, Tau),  % Verificar si Tau es la topología discreta
    writeln('La topología Tau es la topología discreta.').

% Punto de entrada principal
start :-
    writeln('Verificando el ejemplo 1.1.8:'),
    (verify_example_1_1_8 ->
        writeln('Prueba exitosa: τ es la topología discreta.');
        writeln('Prueba fallida: τ no es la topología discreta.')).

