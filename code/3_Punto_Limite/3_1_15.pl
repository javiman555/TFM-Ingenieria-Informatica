:- consult('theory.pl').  % Consultar el archivo theory.pl para definiciones básicas

% Verificar si A es denso en X
es_denso(A, X, Tau) :-
    clausura(A, X, Tau, ClausuraA),
    ClausuraA = X.

% Verificar si cada conjunto abierto no vacío intersecta a A no trivialmente
cada_abierto_intersecta(A, Tau) :-
    forall((member(U, Tau), U \= []), 
           (intersection(A, U, Inter), Inter \= [])).

% Validar la proposición 3.1.15
validar_proposicion_3_1_15(A, X, Tau) :-
    ( es_denso(A, X, Tau) ->
        ( cada_abierto_intersecta(A, Tau) ->
            write('La proposición es verdadera: A es denso en X y cada subconjunto abierto no vacío intersecta a A no trivialmente.')
        ;  write('La proposición es falsa: Aunque A es denso en X, no todos los subconjuntos abiertos no vacíos intersectan a A no trivialmente.')
        )
    ; 
        ( cada_abierto_intersecta(A, Tau) ->
            write('La proposición es verdadera: Cada subconjunto abierto no vacío intersecta a A no trivialmente y A es denso en X.')
        ;  write('La proposición es falsa: Aunque cada subconjunto abierto no vacío intersecta a A no trivialmente, A no es denso en X.')
        )
    ).

% Helper: Intersección de dos listas
intersection([], _, []).
intersection([X|Xs], Ys, [X|Zs]) :-
    member(X, Ys),
    intersection(Xs, Ys, Zs).
intersection([_|Xs], Ys, Zs) :-
    intersection(Xs, Ys, Zs).

% Ejemplo de uso
start :-
    X = [a, b, c, d, e],
    Tau = [[a], [b], [c, d], [a, c, d], [b, c, d, e], X, []],
    A = [a, c],
    validar_proposicion_3_1_15(A, X, Tau).
