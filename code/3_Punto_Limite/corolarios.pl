% Consultar el archivo theory.pl para definiciones básicas
:- consult('theory.pl').

% Definición de vecindad
es_vecindad(N, p, X, Tau) :-
    member(U, Tau),         % Encontrar un conjunto abierto U en la topología Tau
    member(p, U),           % Asegurarse de que p esté en U
    subset(U, N).           % Verificar que U está contenido en N

% Corolario 3.2.7: Verificar si A es cerrado en X
es_cerrado(A, X, Tau) :-
    forall((member(x, X), \+ member(x, A)), % Para cada x en X \ A
           (es_vecindad(N, x, X, Tau),        % Encontrar una vecindad N de x
            subset(N, X \ A))).                % Verificar que N está contenido en X \ A

% Corolario 3.2.8: Verificar si U es abierto en X
es_abierto(U, Tau) :-
    forall((member(x, U)),               % Para cada x en U
           (es_vecindad(N, x, X, Tau),   % Encontrar una vecindad N de x
            subset(N, U))).               % Verificar que N está contenido en U

% Corolario 3.2.9: Verificar si U es abierto en X
es_abierto_via_vecindad(U, Tau) :-
    forall((member(x, U)),               % Para cada x en U
           (member(V, Tau),              % Encontrar un conjunto abierto V en Tau
            member(x, V),                % Asegurarse de que x esté en V
            subset(V, U))).              % Verificar que V está contenido en U

% Definir el espacio topológico y el conjunto
start :-
    X = [a, b, c, d, e],
    Tau = [[a], [b], [c, d], [a, c, d], [b, c, d, e], X, []],
    A = [a, c],
    (es_cerrado(A, X, Tau) ->
        write('El conjunto A es cerrado en X.'), nl
    ; 
        write('El conjunto A no es cerrado en X.'), nl
    ),
    (es_abierto([a], Tau) ->
        write('El conjunto [a] es abierto en X.'), nl
    ; 
        write('El conjunto [a] no es abierto en X.'), nl
    ),
    (es_abierto_via_vecindad([a], Tau) ->
        write('El conjunto [a] es abierto en X mediante vecindad.'), nl
    ; 
        write('El conjunto [a] no es abierto en X mediante vecindad.'), nl
    ).
