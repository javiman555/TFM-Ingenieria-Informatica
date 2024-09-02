% Consultar el archivo theory.pl para acceder a las definiciones básicas
:- consult('theory.pl').

% Definir el conjunto X y la colección B
conjunto_x([a, b, c, d]).
coleccion_b([[a, b], [b, c], [c, d], [a, d]]).

% Verificar si B es una base para una topología sobre X
verificar_base :-
    % Obtener el conjunto X
    conjunto_x(X),
    
    % Obtener la colección B
    coleccion_b(B),
    
    % Verificar la propiedad (a): X debe ser la unión de todos los conjuntos en B
    (cobertura(X, B) ->
        writeln('Propiedad (a) satisfecha: X = ∪ B∈B B.');
        writeln('Error: Propiedad (a) no satisfecha.')
    ),
    
    % Verificar la propiedad (b): Para cualesquiera B1, B2 ∈ B, B1 ∩ B2 debe ser una unión de miembros de B
    (interseccion_union(B) ->
        writeln('Propiedad (b) satisfecha: Para cualesquiera B1, B2 ∈ B, B1 ∩ B2 es una unión de miembros de B.');
        writeln('Error: Propiedad (b) no satisfecha.')
    ).

% Verificar la cobertura de X
cobertura(X, B) :-
    % Generar la unión de todos los conjuntos en B
    findall(Elem, (member(Bi, B), member(Elem, Bi)), Elements),
    list_to_set(Elements, UnionB),
    equal_sets(X, UnionB).

% Verificar si la intersección de cada par de conjuntos en B es una unión de miembros de B
interseccion_union(B) :-
    % Generar todas las intersecciones posibles
    findall(Inter, (member(B1, B), member(B2, B), intersection(B1, B2, Inter)), Intersections),
    % Verificar que cada intersección sea una unión de miembros de B
    forall(member(Inter, Intersections), es_union_de_base(Inter, B)).

% Verificar si un conjunto es una unión de miembros de B
es_union_de_base(Union, B) :-
    % Generar todas las posibles uniones de subconjuntos en B
    findall(U, (subsets(B, Subsets), union(Subsets, U)), Unions),
    % Comprobar si Union está en las uniones generadas
    member(Union, Unions).

% Ejecutar la verificación
start:- verificar_base.

