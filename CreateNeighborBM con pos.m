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

    if q.pos == 0
        disp ('Por hacer ');
        
        % Aqui tengo que inicializar vcs con 1 si el elemento de los
        % vectores en la posicion 1 es el mayor de los numeros por vector
        % que se corresponde con el numero de elementos del vector.
        
        vcs = zeros(size(q.combinations,2),1);
        vcs(size(q.combinations,2),1) = 1;
        
        qnew = q.combinations;
        
%         b = q.combinations{1,1};
%         b = q.combinations(1,1);
%         b = q.combinations{1,cv};%(VectPosCantComb(cv,1));
        CCombinaciones = size(q.combinations,2);
        for cv = CCombinaciones : -1 :  1
%             qnew(1,cv) = q.combinations(1,cv);
%                 qnew.combinations(1,cv) = q.combinations(1,cv);
%                 cv=4;
            numelem = numel(qnew{1,cv}); 
%                 numelem = numel(q.combinations{1,cv}); 
%                 b = q.combinations{1,cv};%(VectPosCantComb(cv,1));
            %             b = circshift(b,[0,-1]);

            if vcs(cv,1)==1
                if cv ~= CCombinaciones
                    vcs(cv,1)=0;
                    if qnew{1,cv}(1) == numelem
%                         if qnew.combinations{1,cv}(1) == numelem
                        if cv ~= 1
                            vcs(cv-1,1)=1;
                        end
                    end
                end
%                 qnew(1,cv) = circshift(q(1,cv),[0,-1]);
                qnew{1,cv}= circshift(qnew{1,cv},[0,-1]);
%                 disp(qnew{1,c}(1));
%                     qnew.combinations(1,cv) = circshift(qnew.combinations(1,cv),[0,-1]);
            end

            disp(qnew(1,cv));
            disp(vcs);
        end
    else
        qnew = q.combinations;
        for cv =1 :  size(q.combinations,2)
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
        end
    end
    
%     m=randi([1 3]);
%     
%     switch m
%         case 1
%             % Do Swap
%             qnew=Swap(q);
%             
%         case 2
%             % Do Reversion
%             qnew=Reversion(q);
%             
%         case 3
%             % Do Insertion
%             qnew=Insertion(q);
%     end

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

