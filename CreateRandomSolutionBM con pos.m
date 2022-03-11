%
% Copyright (c) 2020,
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: Transporte Camag�ey
% Project Title: Tesis de Maestr�a
% 
% 
% Developer: Lenier E. Guevara Yanes
%
% Contact Info: legyanes@gmail.com
%
% Par�metros de entrada: 
%
% x --> estructura que en su campo pos (x.pos) se
% utiliza para calcular el �ndice por el cual se tomar�n los datos para la
% evaluaci�n de la funci�n. En el caso de que x.pos =0 indica que se toma
% la primera posici�n de cada fila.
% 
% model --> modelo generado a partir de las posibles variables por cada
% tipo de veh�culo.
%

function q=CreateRandomSolutionBM(x,model)

    CV = size(model.MatCantComb,1);
    q = cell(1, size(model.MatCantComb,1));

    for i =1:CV
        % Se crea una matriz de n-vectores siendo n la cantidad de tipos de
        % veh�culos del modelo. En cada vector la cantidad de elementos
        % corresponde a las posibles combinaciones que se pueden generar de
        % los par�metros de cada tipo de veh�culo.
        if x.pos ==0 
            % en orden ascendente
            q(i)={1:model.MatCantComb(i)};
        else
            % en orden aleatorio
%             q(i)={randperm(model.MatCantComb(i))};
            
            
             q(i)={1:model.MatCantComb(i)};
        end
    end  
    
  % Aqu� vamos a obtener uan matriz que tendr� tantas filas como cantidad
  % de tipo de veh�culos y y columnas como cantidad de combinaciones
  % posibles de los par�metros de cata tipo de veh�culos.

end