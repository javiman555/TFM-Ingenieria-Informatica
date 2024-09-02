% Consultar el archivo theory.pl para acceder a las definiciones básicas
:- consult('theory.pl').

% Definir el conjunto X
conjunto_x([a, b, c, d]).

% Definir las topologías tau1 y tau2
topologia_tau1([[a, b], [b, c], [a, b, c], [a, b, c, d], []]).
topologia_tau2([[a, b], [b, c], [a, c], [a, b, c, d], []]).

% Definir las bases B1 y B2
base_b1([[a, b], [b, c], [a, b, c]]).
base_b2([[a, b], [b, c], [a, c]]).

% Verificar la primera condición: Para cada B ∈ B1 y cada x ∈ B, existe un B' ∈ B2 tal que x ∈ B' ⊆ B
verificar_condicion_i :-
    base_b1(B1),
    base_b2(B2),
    forall(member(B, B1),
        (member(x, B),
         member(B_prime, B2),
         member(x, B_prime),
         subset(B_prime, B))),
    writeln('Condición (i) satisfecha: Para cada B ∈ B1 y cada x ∈ B, existe un B′ ∈ B2 tal que x ∈ B′ ⊆ B.').

% Verificar la segunda condición: Para cada B ∈ B2 y cada x ∈ B, existe un B′ ∈ B1 tal que x ∈ B′ ⊆ B
verificar_condicion_ii :-
    base_b1(B1),
    base_b2(B2),
    forall(member(B, B2),
        (member(x, B),
         member(B_prime, B1),
         member(x, B_prime),
         subset(B_prime, B))),
    writeln('Condición (ii) satisfecha: Para cada B ∈ B2 y cada x ∈ B, existe un B′ ∈ B1 tal que x ∈ B′ ⊆ B.').

% Verificar que las dos bases producen las mismas topologías
verificar_mismas_topologias :-
    topologia_tau1(Tau1),
    topologia_tau2(Tau2),
    subset(Tau1, Tau2),
    subset(Tau2, Tau1),
    writeln('Las topologías τ1 y τ2 son iguales.').

% Ejecutar las verificaciones
start:- (verificar_condicion_i, verificar_condicion_ii, verificar_mismas_topologias).
