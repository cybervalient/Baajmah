function [Iteration,BCost,Time] = fsaBM (MaxIt,MaxIt2,T0,alpha,model)
    
  %  model.eta=0.1;

CostFunction=@(q) MyCostBM(q,model);       % Cost Function

%% Initialization
    tic;
    Iteration = 0;
    BCost = Inf;
    
%% Initialization

% Create Initial Solution
x.Position=CreateRandomSolutionBM(model);
[x.Cost, x.Sol]=CostFunction(x.Position);

% Update Best Solution Ever Found
BestSol=x;

% Array to Hold Best Cost Values
BestCost=zeros(MaxIt,1);

% Set Initial Temperature
T=T0;


    %% SA Main Loop

    for it=1:MaxIt
        for it2=1:MaxIt2
            % Create Neighbor
            xnew.Position=CreateNeighborBM(x.Position);
            [xnew.Cost, xnew.Sol]=CostFunction(xnew.Position);

            if xnew.Cost<=x.Cost
                % xnew is better, so it is accepted
                x=xnew;
            else
                % xnew is not better, so it is accepted conditionally
                delta=xnew.Cost-x.Cost;
                p=exp(-delta/T);
                if rand<=p
                    x=xnew;
                end
            end

            % Update Best Solution
            if x.Cost<=BestSol.Cost
                BestSol=x;
                bestIteration = it;
            end

        end

        % Store Best Cost
        BestCost(it)=BestSol.Cost;


        % Display Iteration Information
        if BestSol.Sol.IsFeasible
            FLAG=' *';
        else
            FLAG='';
        end
        
         if BCost > BestCost(it)
            BCost = BestCost(it);
            Iteration = it;
        end
        %disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it)) FLAG]);

        % Reduce Temperature
        T=alpha*T;

    %     % Plot Solution
    %     figure(1);
    %     PlotSolution(BestSol.Sol,model);
    %     pause(0.01);

    end
    Time = toc;
end