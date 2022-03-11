function [Iteration,BCost,Time] = fvnsBM (MaxIt,maxK,model)
    
  %  model.eta=0.1;

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

    for it=1:MaxIt  
        k = 1;
         while k<=maxK
                xnew.Position=CreateNeighborBM(x.Position);
                [xnew.Cost, xnew.Sol]=CostFunction(xnew.Position);

                if xnew.Cost<=x.Cost
                    % xnew is better, so it is accepted
                    x=xnew; 
                    break;
                else
                  k = k + 1;  
                end      
         end

        %Update solutions
        if x.Cost<=BestSol.Cost
            BestSol=x;
        end

        if x.Cost<BestSol.Cost
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


%     %% Results
% 
%     disp(['Best Iteration ' num2str(bestIteration)]);
%     figure;
%     plot(BestCost,'LineWidth',2);
%     xlabel('Iteration');
%     ylabel('Best Cost');
%     grid on;
    Time = toc;
end