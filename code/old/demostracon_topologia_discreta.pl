
:- consult('conjuntos.pl'). % Cargar el fichero de conjuntos

% Define el conjunto X
conjunto_x([a, b, c]).

% Define la topolog�a dada t
topologia_tau([[a], [b], [c], [], [a, b], [a, c], [b, c], [a, b, c]]).

% Verifica si t es la topolog�a discreta
es_topologia_discreta :-
    conjunto_x(X),
    potencia(X, P), % Usar la definici�n de potencia del fichero conjuntos.pl
    topologia_tau(Tau),
    % Verificar que Tau es igual a P
    iguales(Tau, P),
    writeln('La topolog�a dada es la topolog�a discreta.').

% Ejecutar las pruebas y demostraciones al iniciar
:- initialization(es_topologia_discreta).

