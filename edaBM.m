clc;
clear;
close all;

%% Problem Definition

% model = CreateRandomModelBaajMaj(0.35,2.13,1.5,4.5,0.1,0.1 ,2 ,0  ,1  ,2 ,0.15 ,18    ,.253  ,15);
model=SelectModel();        % Select Model of the Problem

CostFunction=@(q) MyCostBM(q,model);       % Cost Function

%% EDA Parameters

MaxIt=1200;     % Maximum Number of Iterations
MaxPop = 10; %10000;    % Maximum population individuals
numParents=3; %3000;
bestCost = inf;
bestIteration = 0;

%% Initialization

% Create Initial Solution
for i=1 : MaxPop
  x.Position=CreateRandomSolutionBM(model);
  [x.Cost, x.Sol]=CostFunction(x.Position);  
  population(i)=x;
  costind(i) = x.Cost;
end


for it=1:MaxIt

fitness = sortrows([ (1:MaxPop)' costind(1, :)' ], 2);
%Select the population
idx = fitness(1:numParents, 1);
parents =  population(idx);

%cost=fitness(1,2);
solution = parents(1);

%Update solutions
if(solution.Cost < bestCost)
   bestCost = solution.Cost;
   BestSol = solution;
   bestIteration = it;
end

  % Store Best Cost
    BestCost(it)=BestSol.Cost;


% Display Iteration Information
    if BestSol.Sol.IsFeasible
        FLAG=' *';
    else
        FLAG='';
    end
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it)) FLAG]);
  
%   % Plot Solution
%     figure(1);
%     PlotSolution(BestSol.Sol,model);
%     pause(0.01);
    
    
  %Estimation new popultion
  for i=1:numParents
   costp(i,:) = parents(i).Cost;
  end
  
    means = mean(costp);
    stdev = std(costp);
        
   % Generate new population
    for i = 1: MaxPop
       population(i) = solution;  
       
     xnew.Position=CreateNeighborBM(solution.Position);     
     [xnew.Cost, xnew.Sol]=CostFunction(xnew.Position); 
      
      if xnew.Cost < solution.Cost
       population(i)=xnew;
      else 
        p =  normrnd(means, stdev);  
        if xnew.Cost < p
            population(i)=xnew;
        end
      end
      
      costind(i) = xnew.Cost;  
     % population(i, :) = normrnd(means, stdev);
      %population(i,:) = normrnd(means,stdev).*(means - stdev*tan(pi*(rand(1,1))-0.5));
    end
    
    

end


%% Results

disp(['Best Iteration ' num2str(bestIteration)]);
 
figure;
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;