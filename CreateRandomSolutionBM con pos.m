%
% Copyright (c) 2020,
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: Transporte Camagüey
% Project Title: Tesis de Maestría
% 
% 
% Developer: Lenier E. Guevara Yanes
%
% Contact Info: legyanes@gmail.com
%
% Parámetros de entrada: 
%
% x --> estructura que en su campo pos (x.pos) se
% utiliza para calcular el índice por el cual se tomarán los datos para la
% evaluación de la función. En el caso de que x.pos =0 indica que se toma
% la primera posición de cada fila.
% 
% model --> modelo generado a partir de las posibles variables por cada
% tipo de vehículo.
%

function q=CreateRandomSolutionBM(x,model)

    CV = size(model.MatCantComb,1);
    q = cell(1, size(model.MatCantComb,1));

    for i =1:CV
        % Se crea una matriz de n-vectores siendo n la cantidad de tipos de
        % vehículos del modelo. En cada vector la cantidad de elementos
        % corresponde a las posibles combinaciones que se pueden generar de
        % los parámetros de cada tipo de vehículo.
        if x.pos ==0 
            % en orden ascendente
            q(i)={1:model.MatCantComb(i)};
        else
            % en orden aleatorio
%             q(i)={randperm(model.MatCantComb(i))};
            
            
             q(i)={1:model.MatCantComb(i)};
        end
    end  
    
  % Aquí vamos a obtener uan matriz que tendrá tantas filas como cantidad
  % de tipo de vehículos y y columnas como cantidad de combinaciones
  % posibles de los parámetros de cata tipo de vehículos.

end