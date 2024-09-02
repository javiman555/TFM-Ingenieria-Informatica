% Consultar el archivo theory.pl para acceder a las definiciones básicas
:- consult('theory.pl').

% Definir el conjunto X y la topología tau
conjunto_x([a, b, c, d]).
topologia_tau([[a, b, c], [b, c, d], [a, d], [a, b, d], [a, b, c, d], []]).

% Definir la base B
base_b([[a, b], [b, c], [c, d], [a, d]]).

% Verificar la propiedad (i) si B es una base
verificar_propiedad_i :-
    conjunto_x(X),
    topologia_tau(Tau),
    base_b(B),
    forall(member(U, Tau),
        (forall(member(X, U),
            (member(Bi, B),
             member(X, Bi),
             subset(Bi, U))))),
    writeln('Propiedad (i) satisfecha: Para cada x ∈ U ∈ τ, existe B ∈ B tal que x ∈ B ⊆ U.').

% Verificar la propiedad (ii) si la condición se cumple
verificar_propiedad_ii :-
    conjunto_x(X),
    topologia_tau(Tau),
    base_b(B),
    % Generar todas las posibles uniones de conjuntos en B
    findall(U, (member(B1, B), member(B2, B), union(B1, B2, U)), Unions),
    % Verificar si cada conjunto en Tau puede ser expresado como una unión de miembros de B
    forall(member(U, Tau), (member(U, Unions) ; subset(U, Unions))),
    writeln('Propiedad (ii) satisfecha: Si para cada U ∈ τ y cada x ∈ U existe un B ∈ B tal que x ∈ B ⊆ U, entonces B es una base de τ.').

% Ejecutar la verificación
start:- (verificar_propiedad_i, verificar_propiedad_ii).
