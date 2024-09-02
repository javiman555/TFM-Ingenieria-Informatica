
:- consult('conjuntos.pl'). % Cargar el fichero de conjuntos

% Define el conjunto X
conjunto_x([a, b, c]).

% Define la topología dada t
topologia_tau([[a], [b], [c], [], [a, b], [a, c], [b, c], [a, b, c]]).

% Verifica si t es la topología discreta
es_topologia_discreta :-
    conjunto_x(X),
    potencia(X, P), % Usar la definición de potencia del fichero conjuntos.pl
    topologia_tau(Tau),
    % Verificar que Tau es igual a P
    iguales(Tau, P),
    writeln('La topología dada es la topología discreta.').

% Ejecutar las pruebas y demostraciones al iniciar
:- initialization(es_topologia_discreta).

