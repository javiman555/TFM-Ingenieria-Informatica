% 1_Espacios_Topologicos/check_topology.pl

:- [theory].  % Importa el archivo theory.pl

% Definición del conjunto X y la colección τ1
set_X([a, b, c, d, e, f]).
tau_1([[a, c, d], [], [a], [c, d], [b, c, d, e, f], [a, b, c, d, e, f]]).

% Comprobación de si τ1 es una topología sobre X
check_tau_1_is_topology :-
    set_X(X),
    tau_1(T1),
    topology(X, T1),
    writeln('τ1 es una topología sobre X.').

% Inicio del programa
start :- initialization(main).

main :-
    writeln('Verificando si τ1 es una topología sobre X...'),
    (check_tau_1_is_topology -> true; writeln('τ1 no es una topología sobre X.')).
