% Consultar el archivo theory.pl para acceder a las definiciones básicas
:- consult('theory.pl').

% Definir el conjunto X y la topología τ1
conjunto_x([a, b, c, d, e, f]).
topologia_tau1([ [a, b, c, d, e, f], [], [a], [c, d], [a, c, d], [b, c, d, e, f] ]).

% Definir la colección B
coleccion_b([[a], [c, d], [b, c, d, e, f]]).

% Verificar que B es una base para τ1
verificar_base_tau1 :-
    % Obtener el conjunto X
    conjunto_x(X),
    
    % Obtener la topología τ1
    topologia_tau1(Tau1),
    
    % Obtener la colección B
    coleccion_b(B),
    
    % Verificar que B está contenida en τ1
    (subset(B, Tau1) ->
        writeln('B está contenida en τ1.');
        writeln('Error: B no está contenida en τ1.')
    ),
    
    % Verificar que cada conjunto en τ1 puede ser expresado como una unión de conjuntos en B
    (forall(
        member(Subset, Tau1),
        (es_union_de_base(Subset, B) ->
            format('El conjunto ~w es una unión de miembros de B.~n', [Subset]);
            format('Error: El conjunto ~w NO es una unión de miembros de B.~n', [Subset])
        )
    ) ->
        writeln('Todos los conjuntos en τ1 son uniones de miembros de B.');
        writeln('Error: No todos los conjuntos en τ1 son uniones de miembros de B.')
    ).

% Verificar si un conjunto es una unión de miembros de B
es_union_de_base(Subset, B) :-
    % Encontrar todas las posibles uniones de subconjuntos en B
    findall(U, subset_of_unions(Subset, B, U), Unions),
    % Comprobar si Subset está en la lista de uniones
    member(Subset, Unions).

% Generar todas las posibles uniones de subconjuntos en B
subset_of_unions(Subset, B, Union) :-
    subset_of_unions_aux(Subset, B, Union, []).

% Generar todas las posibles uniones de subconjuntos en B
subset_of_unions_aux(Subset, [], Union, Union) :-
    % Cuando no hay más subconjuntos, verificamos la unión
    subset(Union, Subset),
    !.
subset_of_unions_aux(Subset, [H|T], Union, Acc) :-
    % Añadir el subconjunto actual a la unión y continuar
    union(Acc, H, NewAcc),
    subset_of_unions_aux(Subset, T, Union, NewAcc);
    % También intentamos sin añadir el subconjunto actual
    subset_of_unions_aux(Subset, T, Union, Acc).

% Ejecutar la verificación
start:- verificar_base_tau1.

