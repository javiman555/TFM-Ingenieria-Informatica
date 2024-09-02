% Consultar el archivo theory.pl para acceder a las definiciones básicas
:- consult('theory.pl').

% Definir el conjunto X y la colección B
conjunto_x([a, b, c]).
coleccion_b([[a], [c], [a, b], [b, c]]).

% Verificar que B no es una base para ninguna topología sobre X
verificar_no_base :-
    % Obtener el conjunto X
    conjunto_x(X),
    
    % Obtener la colección B
    coleccion_b(B),
    
    % Generar la topología τ a partir de todas las uniones de subconjuntos en B
    findall(Union, es_union_de_base(Union, B), Tau),
    % Añadir el conjunto vacío a Tau
    append(Tau, [[]], Tau1),
    % Añadir el conjunto X a Tau1
    append(Tau1, [X], Tau2),
    % Eliminar duplicados en Tau2
    list_to_set(Tau2, TauFinal),

    % Mostrar la topología generada
    format('La topología generada τ = ~w~n', [TauFinal]),

    % Verificar si τ cumple con las propiedades de una topología
    (topology(X, TauFinal) ->
        writeln('τ es una topología.');
        writeln('τ NO es una topología.')
    ),

    % Verificar si el conjunto {b} está en τ
    (member([b], TauFinal) ->
        writeln('El conjunto {b} está en τ.');
        writeln('Error: El conjunto {b} NO está en τ.')
    ).

% Verificar si un conjunto es una unión de miembros de B
es_union_de_base(Subset, B) :-
    % Generar todas las posibles uniones de subconjuntos en B
    subset_of_unions(Subset, B, Union),
    % Verificar si Subset es una unión de los miembros de B
    subset(Union, Subset).

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
start:- verificar_no_base.
