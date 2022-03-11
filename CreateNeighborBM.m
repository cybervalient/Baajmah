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

function qnew=CreateNeighborBM(q)
    
% Tengo que seleccionar  vector a vector de combinaciones para ir cambiando
% según sea el caso

    qnew = q;
    for cv =1 :  size(qnew,2)
        m=randi([0 3]);
        switch m
            case 0
                % Do nothing
            case 1
                % Do Swap
                qnew{1,cv} = Swap(qnew{1,cv});
            case 2
                % Do Reversion
                qnew{1,cv} = Reversion(qnew{1,cv});
            case 3
                % Do Insertion
                qnew{1,cv} = Insertion(qnew{1,cv});
        end
      
%         qnew{1,cv} = cshift(qnew{1,cv});
 

    end
end

function qnew=cshift(q)
    qnew=circshift(q,1);
end

function qnew=Swap(q)

    n=numel(q);
    
    i=randsample(n,2);
    i1=i(1);
    i2=i(2);
    
    qnew=q;
    qnew([i1 i2])=q([i2 i1]);
    
end

function qnew=Reversion(q)

    n=numel(q);
    
    i=randsample(n,2);
    i1=min(i(1),i(2));
    i2=max(i(1),i(2));
    
    qnew=q;
    qnew(i1:i2)=q(i2:-1:i1);

end

function qnew=Insertion(q)

    n=numel(q);
    
    i=randsample(n,2);
    i1=i(1);
    i2=i(2);
    
    if i1<i2
        qnew=[q(1:i1-1) q(i1+1:i2) q(i1) q(i2+1:end)];
    else
        qnew=[q(1:i2) q(i1) q(i2+1:i1-1) q(i1+1:end)];
    end

end

