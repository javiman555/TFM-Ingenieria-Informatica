% 1_Espacios_Topologicos/theory.pl

% Definición de la topología cofinita sobre el conjunto N de números naturales
cofinite_topology(N, Tau) :-
    findall(S, (subset(S, N), cofinite(S, N)), Tau).

% Un conjunto S es cofinito en N si su complemento en N es finito o si S es el conjunto vacío
cofinite(S, N) :-
    empty_set(S);
    (subtract(N, S, Complement), length(Complement, L), L < infinite).

% Definición de Sn = {1} ∪ {n+1} ∪ {n+2} ∪ ... 
sn(N, S) :-
    S = [1|Tail],
    findall(M, (member(M, N), M > N), Tail).

% Verificación si el conjunto {1} es abierto en la topología cofinita
is_one_open(Tau) :-
    member([1], Tau).

% Invertir una lista
reverse_list([], []).
reverse_list([H|T], Rev) :-
    reverse_list(T, RevT),
    append(RevT, [H], Rev).

% Ejemplo de uso: Verificar el ejemplo 1.2.3
start :-
    N = [1,2,3,4,5,6,7,8,9,10],  % Definir un conjunto finito de números para propósitos de demostración
    cofinite_topology(N, Tau), % Definir la topología cofinita
    findall(S, (member(M, N), sn(M, S)), SnList), % Generar los conjuntos Sn
    intersection(SnList, Intersection), % Intersección infinita de los conjuntos Sn
    (member(Intersection, Tau) ->
        writeln('La intersección infinita de los conjuntos abiertos Sn es un conjunto abierto.');
        writeln('La intersección infinita de los conjuntos abiertos Sn no es un conjunto abierto.')),
    (member([1], Tau) ->
        writeln('El conjunto {1} es abierto en la topología cofinita.');
        writeln('El conjunto {1} no es abierto en la topología cofinita.')).
