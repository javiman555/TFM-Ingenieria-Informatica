% Definición de un conjunto cerrado en R
es_cerrado(S) :-
    forall((member(p, R), \+ member(p, S)),  % Para cada punto p no en S
           (\+ (es_vecindad_que_contiene_p(p, S)))). % Verificar que hay una vecindad que no intersecta S

% Helper: Verificar si existe una vecindad que contiene p y está contenida en R \ S
es_vecindad_que_contiene_p(p, S) :-
    % Para simplificar, consideramos vecindades (a, b) que son abiertos
    forall((a < p, p < b), 
           (a < p, p < b, \+ (member(x, S), a < x, x < b))).

% Helper: Comprobar si un número es supremo de un conjunto
es_supremo(S, p) :-
    forall((member(x, S), x =< p), true),   % p es una cota superior de S
    (   \+ (member(x, S), x > p)            % p es la menor cota superior
    -> true
    ;   false
    ).

% Verificar si un conjunto T es tanto abierto como cerrado
verificar_abierto_y_cerrado(T, R) :-
    % Verificar si T es abierto
    forall((member(x, T)), 
           (es_vecindad_de_x(x, T, R))),
    % Verificar si T es cerrado
    es_cerrado(T),
    (   T = R
    -> write('T es igual a R.')
    ;   T = []
    -> write('T es el conjunto vacío.')
    ;  write('T es un conjunto abierto y cerrado que no es ni R ni el conjunto vacío.')
    ).

% Helper: Verificar si x tiene una vecindad contenida en T
es_vecindad_de_x(x, T, R) :-
    member(a, R),
    member(b, R),
    a < x, x < b,
    subset([a, b], T).  % Verificar que (a, b) ⊆ T

% Ejemplo de uso
start :-
    R = [-inf, inf], % Definir el conjunto de números reales (R)
    T = [1, 2, 3],  % Ejemplo de conjunto que es tanto abierto como cerrado
    verificar_abierto_y_cerrado(T, R).
