% Definición del espacio topológico
conjunto(X, [a, b, c, d, e]).
topologia(Tau, [[a, b, c, d, e], [], [a], [c, d], [a, c, d], [b, c, d, e]]).

% Complemento de un conjunto en X
complemento([], _, []).
complemento([H|T], X, Comp) :-
    member(H, X),
    complemento(T, X, CompRest),
    Comp = CompRest.
complemento([H|T], X, [H|CompRest]) :-
    \+ member(H, X),
    complemento(T, X, CompRest).

% Conjuntos cerrados en la topología Tau
conjuntos_cerrados(X, Tau, Cerrados) :-
    findall(Comp, (member(U, Tau), complemento(U, X, Comp)), CerradosUnicos),
    sort(CerradosUnicos, Cerrados).

% Clausura de un conjunto en el espacio topológico
clausura(A, X, Tau, ClausuraA) :-
    conjuntos_cerrados(X, Tau, Cerrados),
    findall(C, (member(C, Cerrados), subset(A, C)), CerradosQueContienenA),
    sort(CerradosQueContienenA, [ClausuraA|_]).

% Verificaciones específicas del ejemplo 3.1.11
verificar_ejemplo :-
    conjunto(X, _),
    topologia(Tau, _),
    clausura([b], X, Tau, ClausuraB),
    clausura([a, c], X, Tau, ClausuraAC),
    clausura([b, d], X, Tau, ClausuraBD),
    write('Clausura de {b}: '), write(ClausuraB), nl,
    write('Clausura de {a, c}: '), write(ClausuraAC), nl,
    write('Clausura de {b, d}: '), write(ClausuraBD), nl.

start:- verificar_ejemplo.
