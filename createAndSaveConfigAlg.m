function createAndSaveConfigAlg()

    Config.SA.MaxIt=1200;
    Config.SA.MaxIt2=80;
    Config.SA.T0=100;
    Config.SA.alpha=0.98; 
    
    Config.VNS.MaxIt=1200;
    Config.VNS.maxK = 80; 


    Config.GRASP.MaxIt=1200;
    Config.GRASP.MaxIt2=80;   

    Config.EDA.MaxIt=1200;
    Config.EDA.MaxPop = 50;
    Config.EDA.numParents=15;

    ModelName ='ConfigAlg.mat';
        
    save(ModelName,'Config'); 
%     model = CreateRandomModelBaajMaj(C1,C2,dij,tij,fm,af,fM,cm,ac,cM ,fmin ,Qkmax,LFmax,W);
% %     ModelName=['Bajmaj_' num2str(C1) '_' num2str(dij) '_'  num2str(tij) '_' num2str(cM)  'x'  num2str(af*60)  'min.mat'];
%     ModelName=['Bajmaj_' RR '_' num2str(C1) '_' num2str(C2) '_' num2str(cM)  ' x '  num2str(af*60)  ' min.mat'];
%         
   save(ModelName,'Config');
        

%    % I=[8 10 14 20 25 30 40 50 60 70];
%    %  J=[3  3  4  4  5  5  6  7  7  8];
%     I=[13 36 12];
%     J=[8 5 4];
%     
%     nModel=numel(I);
%     
%     for k=1:nModel
%         
%         model=CreateRandomModel(I(k),J(k));
%         
%         ModelName=['vrp_' num2str(model.I) 'x' num2str(model.J)];
%         
%         save(ModelName,'model');
%         
%     end

end