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

function [z, sol]= MyCostBM(q,model)

    sol=ParseSolutionBM(q,model);
    
    if sol.IsFeasible
        z = model.C1 * model.dij * model.tij + model.C2 * sol.sumCantVehiculos;
    else
        z = 999999999999999999999999999999999999999999999;
    end
end