% Consultar el archivo con definiciones previas
:- consult('theory.pl').

% Definición de intervalos explícitos en Prolog

% Representación de intervalos abiertos
intervalo(abierto, A, B, X) :- 
    X > A, X < B.

% Representación de intervalos cerrados
intervalo(cerrado, A, B, X) :- 
    X >= A, X =< B.

% Representación de intervalos semi-abiertos a la izquierda
intervalo(semi_abierto_izquierda, A, B, X) :- 
    X >= A, X < B.

% Representación de intervalos semi-abiertos a la derecha
intervalo(semi_abierto_derecha, A, B, X) :- 
    X > A, X =< B.

% Verificar si un intervalo es conexo (todo intervalo en R es conexo)
es_conexo_intervalo(Intervalo, A, B) :- 
    Intervalo = conexo, % Aquí se asume que todo intervalo es conexo
    A < B.

% Verificar si un intervalo es disconexo
es_disconexo_intervalo(Intervalo, A, B) :- 
    \+ es_conexo_intervalo(Intervalo, A, B).

% Comprobar si dos intervalos son homeomorfos
homeomorfos(intervalo(abierto, A1, B1), intervalo(abierto, A2, B2)) :- 
    A1 = A2,
    B1 = B2.
homeomorfos(intervalo(cerrado, A1, B1), intervalo(cerrado, A2, B2)) :- 
    A1 = A2,
    B1 = B2.
homeomorfos(intervalo(semi_abierto_izquierda, A1, B1), intervalo(semi_abierto_izquierda, A2, B2)) :- 
    A1 = A2,
    B1 = B2.
homeomorfos(intervalo(semi_abierto_derecha, A1, B1), intervalo(semi_abierto_derecha, A2, B2)) :- 
    A1 = A2,
    B1 = B2.

% Demostrar que ciertos intervalos no son homeomorfos
demostrar_no_homeomorfos :-
    % Definir los intervalos
    Intervalo1 = intervalo(semi_abierto_derecha, 1, 2),
    Intervalo2 = intervalo(cerrado, 3, 4),
    Intervalo3 = intervalo(semi_abierto_izquierda, 1, 2),
    Intervalo4 = intervalo(semi_abierto_derecha, 0, 2),
    
    % Verificar homeomorfismo para cada caso
    ( homeomorfos(Intervalo1, Intervalo2) ->
        write('(1, 2) es homeomorfo a [3, 4]')
    ; 
        write('(1, 2) no es homeomorfo a [3, 4]')
    ),
    nl,
    
    ( homeomorfos(Intervalo1, Intervalo3) ->
        write('(1, 2) es homeomorfo a (1, 2)')
    ; 
        write('(1, 2) no es homeomorfo a (1, 2)')
    ),
    nl,
    
    ( homeomorfos(Intervalo4, Intervalo2) ->
        write('[0, 2) es homeomorfo a [3, 4]')
    ; 
        write('[0, 2) no es homeomorfo a [3, 4]')
    ),
    nl,

    ( homeomorfos(Intervalo4, Intervalo3) ->
        write('[0, 2) es homeomorfo a (1, 2)')
    ; 
        write('[0, 2) no es homeomorfo a (1, 2)')
    ).

% Función principal para ejecutar ejemplos
start :-
    write('Demostración de que ciertos intervalos no son homeomorfos:'), nl,
    demostrar_no_homeomorfos.
