:- consult('theory.pl').

% Verificar si existe al menos tres subconjuntos distintos que son abiertos y cerrados en una topología cofinita
verify_example :-
    % Definir el conjunto X
    X = [a, b, c],  
    
    % Definir la topología cofinita Tau sobre X
    % Nota: Esta topología contiene todos los subconjuntos cuyo complemento es finito en X
    Tau = [[], [a], [b], [a, b], [c], [a, c], [b, c], [a, b, c]],  
    
    % Verificar si Tau es una topología cofinita
    (cofinita_topology(X, Tau) ->
        % Obtener todos los subconjuntos que son abiertos y cerrados
        findall(S, (member(S, Tau), abierto_y_cerrado(X, Tau, S)), AbiertosYCerrados),
        % Verificar si hay al menos tres subconjuntos distintos
        list_to_set(AbiertosYCerrados, AbiertosYCerradosSet),  % Eliminar duplicados
        length(AbiertosYCerradosSet, Count),
        (Count >= 3 ->
            writeln('El conjunto X tiene al menos tres subconjuntos distintos que son abiertos y cerrados.');
            writeln('El conjunto X no tiene al menos tres subconjuntos distintos que son abiertos y cerrados.'))
    ;
        writeln('La topología Tau no es cofinita.')
    ).

% Punto de entrada principal para verificar el ejemplo
start:-
    writeln('Verificando el ejemplo 1.3.3:'),
    verify_example.
