% Definición del lema 3.3.2
% Supongamos que p es el supremo de S y S es un subconjunto cerrado de R

% Helper: Comprobar si un número es supremo de un conjunto
es_supremo(S, p) :-
    forall((member(x, S), x =< p), true),   % p es una cota superior de S
    (   \+ (member(x, S), x > p)            % p es la menor cota superior
    -> true
    ;   false
    ).

% Helper: Verificar si un conjunto es cerrado en R
es_cerrado(S) :-
    forall((member(p, R), \+ member(p, S)),  % Para cada punto p no en S
           (es_vecindad_que_contiene_p(p, S)  % Verificar que hay una vecindad que no intersecta S
           -> false
           ; true)).

% Helper: Verificar si existe una vecindad que contiene p y está contenida en R \ S
es_vecindad_que_contiene_p(p, S) :-
    % Para simplificar, consideramos vecindades (a, b) que son abiertos
    forall((a < p, p < b), 
           (a < p, p < b, \+ (member(x, S), a < x, x < b))).

% Verificar el lema 3.3.2
verificar_lema_3_3_2(S, p) :-
    es_supremo(S, p),
    es_cerrado(S),
    (   \+ (es_vecindad_que_contiene_p(p, S))
    -> write('El lema 3.3.2 es verdadero: p ∈ S.')
    ;  write('El lema 3.3.2 es falso: p no está en S.')
    ).

% Definir el conjunto S y el supremo p para realizar la verificación
start :-
    S = [1, 2, 3],  % Ejemplo de conjunto cerrado en R
    p = 3,          % Ejemplo de supremo de S
    R = [-inf, inf],% Definir el conjunto de números reales (R)
    verificar_lema_3_3_2(S, p).
