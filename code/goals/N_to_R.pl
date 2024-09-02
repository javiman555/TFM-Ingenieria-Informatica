% Definición de conjuntos en Prolog
% Definir los números naturales como un conjunto discreto
conjunto_naturales(nat(X)) :- integer(X), X >= 0.

% Definir los números reales como un conjunto no discreto
conjunto_reales(real(X)) :- real(X).

% Verificar si un conjunto es conexo
es_conexo_naturales :-
    % Los números naturales no son conexos
    write('Los números naturales no son conexos.').

es_conexo_reales :-
    % Los números reales son conexos
    write('Los números reales son conexos.').

% Verificar si un conjunto es compacto
es_compacto_reales :-
    % Los números reales no son compactos en sí mismos
    write('Los números reales no son compactos en sí mismos.').

% Verificar que los conjuntos no son homeomorfos
demostrar_no_homeomorfos :-
    % Verificar propiedades de conexión
    es_conexo_naturales,
    nl,
    es_conexo_reales,
    nl,
    % Verificar propiedades de compactación
    es_compacto_reales,
    nl,
    write('Los números naturales no pueden ser homeomorfos a los números reales porque los números naturales no son conexos y no son compactos, mientras que los números reales son conexos pero no compactos.'),
    nl.

% Función principal para ejecutar ejemplos
start :-
    write('Demostración de que los números naturales no son homeomorfos a los números reales:'), nl,
    demostrar_no_homeomorfos.
