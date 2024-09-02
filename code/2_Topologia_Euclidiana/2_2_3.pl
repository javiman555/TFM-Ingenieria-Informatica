% Consultar el archivo theory.pl para acceder a las definiciones básicas
:- consult('theory.pl').

% Definir la colección B de intervalos abiertos
coleccion_B([(A, B)]) :-
    real(A),
    real(B),
    A < B.

% Definir la topología Euclidiana sobre R
topologia_euclidiana(Tau) :-
    % Definir todos los intervalos abiertos como elementos de la topología
    findall((A, B), (real(A), real(B), A < B), Tau).

% Verificar si la colección B es una base para la topología Euclidiana sobre R
verificar_base_euclidiana :-
    % Definir la colección B
    findall((A, B), coleccion_B((A, B)), B),
    
    % Definir la topología Euclidiana sobre R
    topologia_euclidiana(Tau),
    
    % Verificar que B es una base para la topología Tau
    base_de_topologia([], Tau, B).

% Ejecutar la verificación
start:- verificar_base_euclidiana.
