% principal.pl

% Cargar los ficheros secundarios
:- consult('conjuntos.pl'). % Cargar el fichero de conjuntos
:- consult('demostraciones.pl'). % Cargar el fichero de demostraciones

% Ejecutar las pruebas y demostraciones al iniciar
:- initialization(probar_demostraciones).

% Agregar otras inicializaciones o comandos aquí si es necesario
