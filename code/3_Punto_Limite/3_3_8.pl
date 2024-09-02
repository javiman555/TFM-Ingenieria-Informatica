% Consultar el archivo theory.pl para definiciones básicas
:- consult('theory.pl').

% Verificar si un conjunto es abierto en el espacio topológico
es_abierto(U, Tau) :-
    member(U, Tau).

% Verificar si un conjunto es cerrado en el espacio topológico
es_cerrado(C, X, Tau) :-
    % Un conjunto es cerrado si su complemento es abierto
    complemento(C, X, Complemento),
    es_abierto(Complemento, Tau).

% Encontrar el complemento de un conjunto en X
complemento([], X, X).
complemento([X|Xs], Y, Complemento) :-
    select(X, Y, TempComplemento),
    complemento(Xs, TempComplemento, Complemento).

% Verificar si el espacio (X, Tau) es conexo
es_conexo(X, Tau) :-
    % Encontrar todos los subconjuntos de X que son abiertos y cerrados
    findall(Sub, (subset(Sub, X), es_abierto(Sub, Tau), es_cerrado(Sub, X, Tau)), Subconjuntos),
    % Filtrar los subconjuntos no vacíos y no iguales a X
    exclude(==(X), Subconjuntos, Sin_X),
    exclude(==([]), Sin_X, Sin_Vacio),
    % Verificar que no haya subconjuntos no vacíos abiertos y cerrados
    (   Sin_Vacio = []
    -> write('El espacio es conexo.')
    ;   write('El espacio no es conexo.')
    ).

% Helper: Verificar si un conjunto es subconjunto de otro
subset([], _).
subset([X|Xs], Y) :-
    member(X, Y),
    subset(Xs, Y).

% Ejemplo de uso
start :-
    X = [a, b, c, d, e],
    Tau = [[a], [b], [c, d], [a, c, d], [b, c, d, e], X, []],
    es_conexo(X, Tau).
