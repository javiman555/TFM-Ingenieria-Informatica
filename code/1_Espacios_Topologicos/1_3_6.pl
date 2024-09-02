:- consult('theory.pl').

% (i) La función f tiene una inversa si, y sólo si, f es biyectiva.
tiene_inversa_biyectiva(F, X, Y) :-
    % Verificar que f es inyectiva
    inyectiva(F, X),
    % Verificar que f es sobreyectiva
    sobreyectiva(F, X, Y).

% Verificar que la función es inyectiva
inyectiva(F, X) :-
    forall(member(X1, X), 
           (call(F, X1, Y1), 
            forall((member(X2, X), X1 \= X2), 
                   (call(F, X2, Y2), Y1 \= Y2))
           )).

% Verificar que la función es sobreyectiva
sobreyectiva(F, X, Y) :-
    forall(member(Y1, Y),
           (exists(X1, call(F, X1, Y1)))
    ).

% Verificar si existe un X1 tal que F(X1) = Y
exists(X1, Goal) :-
    call(Goal), !.

% (ii) Si g1 y g2 son ambas funciones inversas de f, entonces g1 = g2.
son_funciones_inversas_iguales(F, G1, G2, Y) :-
    forall(member(Y1, Y),
           (call(G1, Y1, X1), call(G2, Y1, X2), X1 = X2)).

% (iii) g es una función inversa de f si, y sólo si, f es una función inversa de g.
funcion_inversa_bidireccional(F, G, X, Y) :-
    tiene_inversa_biyectiva(F, X, Y),
    tiene_inversa_biyectiva(G, Y, X).

% Ejemplo de uso
verificar_proposiciones :-
    % Definir conjuntos X e Y
    X = [a, b, c],
    Y = [1, 2, 3],

    % Definir funciones F, G1 y G2
    assertz(f(a, 1)),
    assertz(f(b, 2)),
    assertz(f(c, 3)),

    assertz(g1(1, a)),
    assertz(g1(2, b)),
    assertz(g1(3, c)),

    assertz(g2(1, a)),
    assertz(g2(2, b)),
    assertz(g2(3, c)),

    % Verificar si la función F es biyectiva y tiene una inversa
    (tiene_inversa_biyectiva(f, X, Y) ->
        writeln('f es biyectiva y tiene una inversa.');
        writeln('f no es biyectiva y no tiene una inversa.')),

    % Verificar si g1 y g2 son iguales
    (son_funciones_inversas_iguales(f, g1, g2, Y) ->
        writeln('g1 y g2 son funciones inversas iguales.');
        writeln('g1 y g2 no son funciones inversas iguales.')),

    % Verificar función inversa bidireccional
    (funcion_inversa_bidireccional(f, g1, X, Y) ->
        writeln('g es una función inversa de f y viceversa.');
        writeln('g no es una función inversa de f y viceversa.')).

% Punto de entrada principal
start :-
    writeln('Verificando la Proposición 1.3.6:'),
    verificar_proposiciones.
