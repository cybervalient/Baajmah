function CreateAndSaveModels1BM()

    C1  = 0.35;
    C2  = 2.13;
    dij = 1.5;
    tij = 4.5;
    fm  = 0.1;
    af  = 0.1;
    fM  = 2;
    cm  = 0;
    ac  = 1;
    cM  = 1;
    fmin  = 0.6;
    Qkmax = 18;
    LFmax = .253;
    W = 5;
    
    
    fm = fmin;
    af =fmin:0.1:2;
    af = af(randperm(numel(af)));
    af = af(1);
    
    cM  = [3,5,10];
    cM = cM(randperm(numel(cM)));
    cM = cM(1);
    
%     R19
%     dij = 24.15;
%     tij = 55;

%     R1
    dij = 21.54;
    tij = 54;

    af =0.3;
    cM = 5;
    

   
    

    model = CreateRandomModelBaajMaj(C1,C2,dij,tij,fm,af,fM,cm,ac,cM ,fmin ,Qkmax,LFmax,W);
%     ModelName=['Bajmaj_' num2str(C1) '_' num2str(dij) '_'  num2str(tij) '_' num2str(cM)  'x'  num2str(af*60)  'min.mat'];
    ModelName=['Bajmaj_R1_' num2str(C1) '_' num2str(C2) '_' num2str(cM)  ' x '  num2str(af*60)  ' min.mat'];
        
   save(ModelName,'model');
        

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