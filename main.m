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

clear;
clc;
  
    %% Initialization
    root_path = dir('main.m');  
    % aquí tengo los datos de la configuracion cargados del archivo.
    config = SelectConfigAlgNGUI(strcat(root_path.folder,'\'),'ConfigAlg.mat');
    
     
    
    %% LOAD MODELS to use
    
      
    [file_list, path_n] = uigetfile('.mat', 'Grab the files you want to process','MultiSelect', 'on');

    if iscell(file_list) == 0
        file_list = {file_list};
    end
  
    Result_path = strcat(path_n,'\Resultados\Resultados.xlsx');
%     mat33Excel = readcell('D:\Tema de Tesis Lenier\Tesis_Transporte\BaajMaj 2021 Addiel\Resultados\Resultados.xlsx','Sheet',1,'Range','B2:N3');
%     writecell(mat33Excel,'D:\Tema de Tesis Lenier\Tesis_Transporte\BaajMaj 2021 Addiel\Resultados\Resultados.xlsx','Sheet',2,'Range','B2:N3');
   
    
    
    matExcel = zeros(length(file_list),13);

    
    for i = 1:length(file_list)
        %Specify name of file(i)
        filename = file_list{i};

%         %Load data from file(i)
        model=SelectModelNGUI(path_n,file_list{i});        % Select Model of the Problem

        %% EDA Parameters       
        [matExcel(i,1),matExcel(i,2),matExcel(i,3)] = fedaBM (config.EDA.MaxIt,config.EDA.MaxPop,config.EDA.numParents,model);

        %% SA Parameters
        [matExcel(i,4),matExcel(i,5),matExcel(i,6)] = fsaBM (config.SA.MaxIt,config.SA.MaxIt2,config.SA.T0,config.SA.alpha,model);

        %% VNS Parameters
        [matExcel(i,7),matExcel(i,8),matExcel(i,9)] = fvnsBM (config.VNS.MaxIt,config.VNS.maxK,model);

        %% GRASP Parameters
        [matExcel(i,10),matExcel(i,11),matExcel(i,12)] = fgraspBM (config.GRASP.MaxIt,config.GRASP.MaxIt2,model);

    end
    
    %% Export data to excel.
    
    matTfile = transpose(file_list);
    CeldaFin = strcat('B4:B', num2str(length(file_list)+3));
    writecell(matTfile,Result_path,'Sheet',1,'Range',CeldaFin)
   
    CeldaFin = strcat('C4:N', num2str(length(file_list)+3));
    writematrix(matExcel,Result_path,'Sheet',1,'Range',CeldaFin)
   % 'D:\Tema de Tesis Lenier\Tesis_Transporte\BaajMaj 2021 Addiel\Resultados\Resultados.xlsx'

    
    %CostFunction=@(q) MyCostBM(q,model);       % Cost Function


  
    %% Others
