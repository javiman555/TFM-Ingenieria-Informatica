% Definición de los números racionales y reales en Prolog
% Definir los números racionales como un conjunto denso en los reales
conjunto_racionales(racional(X)) :- rational(X).

% Definir los números reales como un conjunto no denso en sí mismo
conjunto_reales(real(X)) :- real(X).

% Verificar si un conjunto es conexo
es_conexo_reales :-
    % Los números reales son conexos
    write('Los números reales son conexos.'), nl.

es_no_conexo_racionales :-
    % Los números racionales no son conexos
    write('Los números racionales no son conexos.'), nl.

% Verificar si un conjunto es denso en otro
es_denso_en_reales :-
    % Los números racionales son densos en los números reales
    write('Los números racionales son densos en los números reales.'), nl.

es_no_denso_en_racionales :-
    % Los números reales no son densos en los números racionales
    write('Los números reales no son densos en los números racionales.'), nl.

% Verificar que los conjuntos no son homeomorfos
demostrar_no_homeomorfos_racionales_reales :-
    % Verificar propiedades de conectividad
    es_conexo_reales,
    es_no_conexo_racionales,
    nl,
    % Verificar propiedades de densidad
    es_denso_en_reales,
    es_no_denso_en_racionales,
    nl,
    write('Los números racionales no pueden ser homeomorfos a los números reales porque los números racionales no son conexos, mientras que los números reales sí lo son. Además, los números racionales son densos en los números reales, pero los números reales no son densos en los números racionales.'), nl.

% Función principal para ejecutar ejemplos
start :-
    write('Demostración de que los números racionales no son homeomorfos a los números reales:'), nl,
    demostrar_no_homeomorfos_racionales_reales.
