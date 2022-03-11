%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com) 
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPAP108
% Project Title: Solving Vehicle Routing Problem using Simulated Annealing
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function sol=ParseSolutionBM(q,model)
    
    IsFeasible = false;
    McombVehiculos = model.McombVehiculos;   %Matriz n-dimensional de combinaciones de los vehículos.
    VectCantAsientos = model.VectCantAsientos;
    MatCantComb = model.MatCantComb;
    
    if model.pos == 0
        t=ones(size(VectCantAsientos,1));
        VectPosCantComb = t(:,1);
    else
        VectPosCantComb = floor(MatCantComb./model.pos);
    end
    VTiempos = zeros(size(VectCantAsientos,1),1);
    VCantidadVehiculo = zeros(size(VectCantAsientos,1),1);
    for i =1:size(VectCantAsientos,1)
%         disp(VectPosCantComb(i,1));
        
%         b = q{1,i}(VectPosCantComb(i,1));

 %       disp(b);
        b = q(1,i);
        VTiempos(i) = McombVehiculos(q{1,i}(VectPosCantComb(i,1)),1,i)'; 
        VCantidadVehiculo(i) = McombVehiculos(q{1,i}(VectPosCantComb(i,1)),2,i)';
    end
    
    fxv = VCantidadVehiculo./VTiempos;
    fk = sum(fxv);
    fxCAP = sum(fxv.*VectCantAsientos);
    
    if sum(VCantidadVehiculo) <= model.W
        fxv = VCantidadVehiculo./VTiempos;
        fk = sum(fxv);
        if isnan(fk) 
            disp(fk);
        end
        if fk >= model.fmin
            fxCAP = sum(fxv.*VectCantAsientos);
            if model.Qkmax/fxCAP <= model.LFmax
                IsFeasible = true;
            end
        end
    end 
    
    % si no es factible quiere decir que no se cumple alguna de las
    % condiciones por lo que no se toma para evaluar y en la evaluacion del
    % costo se pondrá un número extremadamente grande.
    % OJO  ---> debo poner los valores de todos los elementos dela solución
    % como NaN u otro valor como 0 pero debo mostrarlos.

    sol.fk=fk;
    sol.fxCAP=fxCAP;
    sol.sumCantVehiculos = sum(VCantidadVehiculo);
    sol.VTiempos = VTiempos;
    sol.VCantidadVehiculo = VCantidadVehiculo;
    sol.IsFeasible = IsFeasible;
     
    % Aqui debo poner el valor de la matriz formada por los valores de
    % los vehículos que conforman la solución.
        
end