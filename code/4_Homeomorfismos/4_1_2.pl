% Consultar el archivo theory.pl
:- consult('/theory.pl').

% Ejemplo de uso con los datos proporcionados
start :-
    % Definir el espacio topológico (X, Tau)
    X = [a, b, c, d, e, f],
    Tau = [X, [], [a], [c, d], [a, c, d], [b, c, d, e, f]],
    
    % Definir el subconjunto Y de X
    Y = [b, c, e],
    
    % Obtener la topología del subespacio
    topologia_subespacio(Y, Tau, Tau_Y),
    
    % Mostrar el resultado
    write('La topología del subespacio sobre Y es: '), write(Tau_Y), nl.




