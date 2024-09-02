% Cargar la teoría base
:- consult('theory.pl').

% Definimos los conjuntos y la topología
espacio_topologico(X, Tau) :-
    X = [a, b, c, d, e],
    Tau = [[a, c, d], [b, c, d, e], [a], [c, d], X, []].

% Definimos el subconjunto A
subconjunto_A(A) :-
    A = [a, b, c].

% Verificamos si un punto es un punto límite del subconjunto A
verificar_puntos_limite :-
    espacio_topologico(X, Tau),
    subconjunto_A(A),
    % Chequear cada punto en X si es punto límite de A
    forall(member(Punto, X),
           (punto_limite(Punto, A, Tau) ->
            format('~w es un punto límite de A.~n', [Punto]);
            format('~w NO es un punto límite de A.~n', [Punto]))).

% Predicado principal para ejecutar la validación
validar_ejemplo_3_1_2 :-
    writeln('Validando el ejemplo 3.1.2:'),
    verificar_puntos_limite.

% Ejecutar la validación al cargar el archivo
start:- validar_ejemplo_3_1_2.
