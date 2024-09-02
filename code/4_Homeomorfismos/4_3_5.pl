% Consultar el archivo con definiciones previas
:- consult('theory.pl').

% Verificar si un subconjunto de R es conexo
es_conexo(S) :-
    % Un conjunto S en R es conexo si y sólo si no puede ser dividido en dos conjuntos abiertos y cerrados disjuntos
    \+ (member(X, S), member(Z, S), X < Z,
        between(X, Z, Y),
        \+ member(Y, S),
        % Definir los subconjuntos abiertos y cerrados
        intersection(S, [-inf, Y], S1),
        intersection(S, [Y, inf], S2),
        S1 \= [],
        S2 \= [],
        S1 \= S,
        S2 \= S).

% Helper: Definir la intersección de dos conjuntos
intersection([], _, []).
intersection([X|Xs], Ys, [X|Zs]) :-
    member(X, Ys),
    intersection(Xs, Ys, Zs).
intersection([_|Xs], Ys, Zs) :-
    intersection(Xs, Ys, Zs).

% Verificar si un conjunto es un intervalo
es_intervalo(S) :-
    member(X, S),
    member(Z, S),
    X < Z,
    forall((between(X, Z, Y), Y \= X, Y \= Z), member(Y, S)).

% Verificar si todos los intervalos en R son conexos
demostrar_intervalos_conexos :-
    % Ejemplos de conjuntos
    S1 = [1, 2, 3, 4, 5],  % Ejemplo de intervalo
    S2 = [1, 3, 4, 6],     % No es un intervalo
    (es_conexo(S1) ->
        write('El conjunto S1 es conexo.')
    ; 
        write('El conjunto S1 no es conexo.')),
    nl,
    (es_conexo(S2) ->
        write('El conjunto S2 es conexo.')
    ; 
        write('El conjunto S2 no es conexo.')).

% Verificar si un conjunto conexo es un intervalo
demostrar_conjunto_conexo_intervalo :-
    % Ejemplos de conjuntos
    S1 = [1, 2, 3, 4, 5],  % Ejemplo de intervalo y conexo
    S2 = [1, 3, 4, 6],     % No es un intervalo
    (es_conexo(S1) ->
        (es_intervalo(S1) ->
            write('El conjunto S1 es un intervalo.')
        ; 
            write('El conjunto S1 no es un intervalo.'))
    ; 
        write('El conjunto S1 no es conexo.')
    ),
    nl,
    (es_conexo(S2) ->
        (es_intervalo(S2) ->
            write('El conjunto S2 es un intervalo.')
        ; 
            write('El conjunto S2 no es un intervalo.'))
    ; 
        write('El conjunto S2 no es conexo.')
    ).

% Función principal para ejecutar ejemplos
start :-
    write('Demostrando intervalos conexos:'), nl,
    demostrar_intervalos_conexos,
    nl,
    write('Demostrando conjuntos conexos como intervalos:'), nl,
    demostrar_conjunto_conexo_intervalo.
