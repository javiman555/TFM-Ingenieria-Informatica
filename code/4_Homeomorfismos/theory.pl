% Consultar el archivo theory.pl
:- consult('../3_Punto_limite/theory.pl').

% Definición 4.1.1: La topología del subespacio
topologia_subespacio(Y, Tau, Tau_Y) :-
    % Calcular la intersección de cada conjunto abierto en Tau con Y
    findall(OY, (member(O, Tau), intersection(O, Y, OY), OY \= []), Lista),
    % Eliminar duplicados
    list_to_set(Lista, Tau_Y).

% Helper: Intersección de dos listas
intersection([], _, []).
intersection([X|Xs], Ys, [X|Zs]) :-
    member(X, Ys),
    intersection(Xs, Ys, Zs).
intersection([_|Xs], Ys, Zs) :-
    intersection(Xs, Ys, Zs).

% Helper: Convertir lista a conjunto (elimina duplicados)
list_to_set(List, Set) :-
    sort(List, Set).

% Definición 4.2.1: Homeomorfismo entre dos espacios topológicos
homeomorfismo(X, Tau, Y, Tau1, F) :-
    % (i) f es inyectiva
    inyectiva(F, X, Y),
    
    % (ii) f es sobreyectiva
    sobreyectiva(F, X, Y),
    
    % (iii) para cada U ∈ τ1, f^(-1)(U) ∈ τ
    forall((member(U1, Tau1), f_inv(U1, F, X, Inv), member(Inv, Tau))),
    
    % (iv) para cada V ∈ τ, f(V) ∈ τ1
    forall((member(V, Tau), f(V, F, Y, F1), member(F1, Tau1))).

% Helper: Verificar si f es inyectiva
inyectiva(F, X, Y) :-
    forall((member(X1, X), member(X2, X), call(F, X1, Y1), call(F, X2, Y2), Y1 = Y2), X1 = X2).

% Helper: Verificar si f es sobreyectiva
sobreyectiva(F, X, Y) :-
    forall(member(Y1, Y), (member(X1, X), call(F, X1, Y1))).

% Helper: Función inversa para la definición de homeomorfismo
f_inv(U1, F, X, Inv) :-
    findall(X1, (member(X1, X), call(F, X1, Y1), member(Y1, U1)), Inv).

% Helper: Función f que mapea un conjunto V a su imagen bajo f
f(V, F, Y, F1) :-
    findall(Y1, (member(X1, V), call(F, X1, Y1)), F1).

% Definición 4.3.3: Verificar si un subconjunto es un intervalo
es_intervalo(S) :-
    % Verificar la propiedad de intervalo
    forall((member(X, S), member(Z, S), X < Z, between(X, Z, Y)), member(Y, S)).

% Helper: Verificar si un número está en el intervalo abierto [X, Z]
between(X, Z, Y) :-
    X < Y, Y < Z.

