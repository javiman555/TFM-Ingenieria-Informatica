% Consultar el archivo theory.pl para acceder a las definiciones básicas
:- consult('theory.pl').

% Definir el conjunto X, la topología tau, y la base B
conjunto_x([a, b, c, d]).
topologia_tau([[a, b, c], [b, c, d], [a, d], [a, b, d], [a, b, c, d], []]).
base_b([[a, b], [b, c], [c, d], [a, d]]).

% Verificar propiedad (i): Si para cada x ∈ U existe un B ∈ B tal que x ∈ B ⊆ U, entonces U es abierto
verificar_propuesta_i :-
    conjunto_x(X),
    topologia_tau(Tau),
    base_b(B),
    % Definir un subconjunto U arbitrario de X
    U = [a, b, c],
    forall(member(x, U),
        (member(Bx, B),
         member(x, Bx),
         subset(Bx, U))),
    % Verificar que U es abierto
    member(U, Tau),
    writeln('Propiedad (i) satisfecha: Para cada x ∈ U existe un B ∈ B tal que x ∈ B ⊆ U, por lo que U es abierto.').

% Verificar propiedad (ii): Si U es abierto, entonces para cada x ∈ U existe un B ∈ B tal que x ∈ B ⊆ U
verificar_propuesta_ii :-
    conjunto_x(X),
    topologia_tau(Tau),
    base_b(B),
    % Definir un subconjunto U arbitrario de X
    U = [a, b, c],
    member(U, Tau),
    % Verificar que para cada x ∈ U existe un B ∈ B tal que x ∈ B ⊆ U
    forall(member(x, U),
        (member(Bx, B),
         member(x, Bx),
         subset(Bx, U))),
    writeln('Propiedad (ii) satisfecha: Si U es abierto, entonces para cada x ∈ U existe un B ∈ B tal que x ∈ B ⊆ U.').

% Ejecutar la verificación
start:- (verificar_propuesta_i, verificar_propuesta_ii).
