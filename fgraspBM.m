function [Iteration,BCost,Time] = fgraspBM (MaxIt,MaxIt2,model)

    CostFunction=@(q) MyCostBM(q,model);       % Cost Function


    %% Initialization
    tic;
    Iteration = 0;
    BCost = Inf;
    
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

        if xnew.Cost<=x.Cost
            % xnew is better, so it is accepted
            x=xnew;
        end

        % Update Best Solution
        if x.Cost<=BestSol.Cost
            BestSol=x;
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

        if BCost > BestCost(it)
            BCost = BestCost(it);
            Iteration = it;
        end
        
        %disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it)) FLAG]);
    end
%  
% 
%     disp(['Best Iteration ' num2str(bestIteration)]);
%     figure;
%     plot(BestCost,'LineWidth',2);
%     xlabel('Iteration');
%     ylabel('Best Cost');
%     grid on;

    Time = toc;
end