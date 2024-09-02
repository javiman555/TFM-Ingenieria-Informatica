% Consultar el archivo theory.pl para reutilizar definiciones básicas
:- consult('../3_Punto_limite/theory.pl').

% Definición de espacios conexos
es_conexo(X, Tau) :-
    \+ (member(T1, Tau), T1 \= [], % Para cualquier conjunto abierto no vacío
        member(T2, Tau),            % Existen subconjuntos abiertos y cerrados no vacíos
        T2 \= [],
        T1 \= X,
        T2 \= X,
        intersection(T1, T2, [])).

% Definición de homeomorfismo entre dos espacios topológicos
homeomorfismo(X, Tau, Y, Tau1, F) :-
    % (i) f es inyectiva
    inyectiva(F, X, Y),
    
    % (ii) f es sobreyectiva
    sobreyectiva(F, X, Y),
    
    % (iii) para cada U ∈ τ1, f^(-1)(U) ∈ τ
    forall((member(U1, Tau1), f_inv(U1, F, X, Inv), member(Inv, Tau))),
    
    % (iv) para cada V ∈ τ, f(V) ∈ τ1
    forall((member(V, Tau), f(V, F, Y, F1), member(F1, Tau1))).

% Helper: Verificar si f es inyectiva
inyectiva(F, X, Y) :-
    forall((member(X1, X), member(X2, X), call(F, X1, Y1), call(F, X2, Y2), Y1 = Y2), X1 = X2).

% Helper: Verificar si f es sobreyectiva
sobreyectiva(F, X, Y) :-
    forall(member(Y1, Y), (member(X1, X), call(F, X1, Y1))).

% Helper: Función inversa para la definición de homeomorfismo
f_inv(U1, F, X, Inv) :-
    findall(X1, (member(X1, X), call(F, X1, Y1), member(Y1, U1)), Inv).

% Helper: Función f que mapea un conjunto V a su imagen bajo f
f(V, F, Y, F1) :-
    findall(Y1, (member(X1, V), call(F, X1, Y1)), F1).

% Proposición 4.3.2: Cualquier espacio homeomorfo a un espacio conexo es conexo
proposicion_4_3_2(X, Tau, Y, Tau1, F) :-
    % Verificar si Y es conexo
    es_conexo(Y, Tau1),
    
    % Verificar si X es homeomorfo a Y
    homeomorfismo(X, Tau, Y, Tau1, F),
    
    % Mostrar que X también es conexo
    (es_conexo(X, Tau) ->
        write('Como (X, τ) es homeomorfo a (Y, τ1) y (Y, τ1) es conexo, entonces (X, τ) también es conexo.')
    ; write('(X, τ) no es conexo, a pesar de ser homeomorfo a (Y, τ1).')).

% Ejemplo de uso con los datos proporcionados
start :-
    % Definir el espacio topológico (Y, Tau1) conexo
    Y = [a, d, e],
    Tau1 = [[a, d, e], [], [a], [d], [a, d], [d, e]],
    
    % Definir el espacio topológico (X, Tau) y la función f
    X = [a, b, c, d, e],
    Tau = [[a, b, c, d, e], [], [a], [c, d], [a, c, d], [b, c, d, e]],
    
    % Definir una función f como un ejemplo (esto es solo ilustrativo)
    F = (X, Y, f(X, Y)),  % Definir la función f según el ejemplo
    
    % Comprobar la proposición
    proposicion_4_3_2(X, Tau, Y, Tau1, F).

