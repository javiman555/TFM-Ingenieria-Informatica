% Consultar el archivo theory.pl para definiciones básicas
:- consult('theory.pl').

% Definición de vecindad
es_vecindad(N, p, X, Tau) :-
    member(U, Tau),         % Encontrar un conjunto abierto U en la topología Tau
    member(p, U),           % Asegurarse de que p esté en U
    subset(U, N),           % Verificar que U está contenido en N
    write('Vecindad encontrada: '), write(U), nl.

% Verificar si un punto x es un punto límite de A
es_punto_limite(X, A, Tau, x) :-
    write('Verificando si '), write(x), write(' es un punto límite de A...'), nl,
    forall((es_vecindad(N, x, X, Tau)),  % Para cada vecindad N de x
           (intersection(A, N, Inter),  % Intersección de A con N
            (   Inter \= []
            ->  (   (member(X, Inter), X \= x)
                ->  true
                ;   write('Intersección contiene solo el punto: '), write(Inter), nl,
                    fail
                )
            ;   write('Intersección vacía para vecindad: '), write(N), nl,
                fail
            ))),
    write('El punto '), write(x), write(' es un punto límite de A.'), nl.

% Helper: Intersección de dos listas
intersection([], _, []).
intersection([X|Xs], Ys, [X|Zs]) :-
    member(X, Ys),
    intersection(Xs, Ys, Zs).
intersection([_|Xs], Ys, Zs) :-
    intersection(Xs, Ys, Zs).

% Helper: Verificar si un conjunto es un subconjunto de otro
subset([], _).
subset([X|Xs], Y) :-
    member(X, Y),
    subset(Xs, Y).

% Definir el espacio topológico y el conjunto
start :-
    X = [a, b, c, d, e],
    Tau = [[a], [b], [c, d], [a, c, d], [b, c, d, e], X, []],
    A = [a, c],
    Punto = b,  % Cambiar esto para probar otros puntos
    (es_punto_limite(X, A, Tau, Punto) ->
        true
    ; 
        write('El punto '), write(Punto), write(' no es un punto límite de A.'), nl
    ).
