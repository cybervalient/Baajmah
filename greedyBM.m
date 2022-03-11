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

clc;
clear;
close all;

%% Problem Definition

% model = CreateRandomModelBaajMaj(0.35,2.13,1.5,4.5,0.1,0.1 ,2 ,0  ,1  ,2 ,0.15 ,18    ,.253  ,15);
model=SelectModel();        % Select Model of the Problem

CostFunction=@(q) MyCostBM(q,model);       % Cost Function

%% SA Parameters

MaxIt=1200;     % Maximum Number of Iterations

MaxIt2=80;      % Maximum Number of Inner Iterations

bestIteration = 0;

%% Initialization

% Create Initial Solution
x.Position=CreateRandomSolutionBM(model);
[x.Cost, x.Sol]=CostFunction(x.Position);

% Update Best Solution Ever Found
BestSol=x;

% Array to Hold Best Cost Values
BestCost=zeros(MaxIt,1);


%% GREDDY Main Loop

for it=1:MaxIt
    IsFeasible = false;
    while IsFeasible == false
         % Create Neighbor
        xnew.Position=CreateNeighborBM(x.Position);
        [xnew.Cost, xnew.Sol]=CostFunction(xnew.Position);
        IsFeasible = xnew.Sol.IsFeasible;
    end
% %     for it2=1:MaxIt2
% %         
% %         Create Neighbor
% %         xnew.Position=CreateNeighborBM(x.Position);
% %         [xnew.Cost, xnew.Sol]=CostFunction(xnew.Position);
% %         
        if xnew.Cost<=x.Cost
            % xnew is better, so it is accepted
            x=xnew;
% %             
% %         else
% %             % xnew is not better, so it is accepted conditionally
% %             delta=xnew.Cost-x.Cost;
% %             p=exp(-delta/T);
% %             
% %             if rand<=p
% %                 x=xnew;
% %             end
            
        end
        
        % Update Best Solution
        if x.Cost<=BestSol.Cost
            BestSol=x;
            bestIteration = it;
        end
        
% %     end
    
    % Store Best Cost
    BestCost(it)=BestSol.Cost;

    
    % Display Iteration Information
    if BestSol.Sol.IsFeasible
        FLAG=' *';
    else
        FLAG='';
    end
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it)) FLAG]);
    
    % Reduce Temperature
% %     T=alpha*T;
    
%     % Plot Solution
%     figure(1);
%     PlotSolution(BestSol.Sol,model);
%     pause(0.01);
    
end

%% Results

disp(['Best Iteration ' num2str(bestIteration)]);
figure;
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;

