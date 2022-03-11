%
% Copyright (c) 2020, 
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: LEGY001
% Project Title: Solving BaajMaj
% Publisher: 
% 
% Developer: Lenier E. Guevara Yanes
% 
% Contact Info: legyanes@gmail.com
%

% clear;
% clc;

% Par�metros de entrada:
%
%   C1 y C2 --> factores de conversi�n y pesos relativos de
%               los t�rminos de la funci�n objetivo.
%   dij --> demanda total de transportaci�n.
%   tij --> Tiempo total del recorrido de la ruta.
%   fm --> se refiere a la frecuencia m�nima para ese tipo de veh�culo.
%   fM --> se refiere a la frecuencia m�xima para ese tipo de veh�culo.
%   cm --> se refiere a la cantidad m�nima de ese tipo de veh�culo.
%   cM --> se refiere a la cantidad m�xima de ese tipo de veh�culo.
%
%  Par�metros de restricciones,
%
%   fmin --> frecuencia m�nima.
%   Qkmax --> m�ximo flujo en la ruta.
%   LFmax --> m�ximo factor de carga permitido.
%   W --> tama�o de la flota.


 function model=CreateRandomModelBaajMaj(C1,C2,dij,tij,fm,af,fM,cm,ac,cM,fmin,Qkmax,LFmax,W)


%     fm =0;
%     af =0;
%     fM =0;
%     cm =0;
%     ac =0;
%     cM =0;
    
    %% TODO Lectura de la matriz de veh�culos.
    
    % Leer de un excel la matrix donde se pongan los datos de los tipos de
    % vehiculos.
    
    

    %%
    MatDatVehic =   [25 .1 2 0 18;   % Paz 25
                     28 .1 2 0 4;    % Diana 28
                     32 .1 2 0 5     % Gran Porte 32
                     40 .3 4 1 4];  
%     beep;
%     tic;
%     TTVMVehiculos = MatDatVehic(:,3:end);
    VMVehiculos= zeros(size(MatDatVehic,1),1);
    nVMVehiculos = size(MatDatVehic,1);

%     %CVect  --> CantVectXVehic  %%Vector Cantidad de combinaciones por tipo de veh�culo
%     
%     VectCantCombXVehic = cell(1, size(MatDatVehic,1));

    for i =1:nVMVehiculos
        if fm+af+fM+cm+ac+cM == 0  
            %Antiguamente con estos indices porque la matriz MatDatVehic
            %ten�a el numero delante ahora es el indice menos 1
            %VMVehiculos(i) =  numel(MatDatVehic(i,3):0.1:MatDatVehic(i,4)) * numel(MatDatVehic(i,5):1:MatDatVehic(i,6));
            VMVehiculos(i) =  numel(MatDatVehic(i,2):0.1:MatDatVehic(i,3)) * numel(MatDatVehic(i,4):1:MatDatVehic(i,5));
        else
            VMVehiculos(i) =  numel(fm:af:fM) * numel(cm:ac:cM);
           % TPTVMVehiculos = {fm:af:fM,cm:ac:cM};
        end
        
        %         VectCantCombXVehic(i)={1:1:VMVehiculos(i)};
    end    

    CVMVehiculos = zeros(max(VMVehiculos),2,nVMVehiculos);

    for i = 1 : nVMVehiculos
        if fm+af+fM+cm+ac+cM == 0 
            TPTVMVehiculos = {MatDatVehic(i,2):0.1:MatDatVehic(i,3),MatDatVehic(i,4):1:MatDatVehic(i,5)};
        else
            TPTVMVehiculos = {fm:af:fM,cm:ac:cM};
        end
        VX=cell(1,numel(TPTVMVehiculos));
        [VX{:}]=ndgrid(TPTVMVehiculos{:});
        VX=cellfun(@(X) reshape(X,[],1),VX,'UniformOutput',false);
        VX=horzcat(VX{:});
        
        %TODO  Aqu� agrego la cantidad de 
        
        
        if not (size(VX,1) == max(VMVehiculos))
            VX(max(VMVehiculos),2)=0;
        end
        CVMVehiculos(:,:,i) = VX;
    end      
    
     
 % Tabla de veh�culos    MatDatVehic

 %  Matrix formada por vectores con los datos de los veh�culos
 %  estructurados de la siguiente forma: [v ca fm fM cm cM] d�nde:
 %  v  --> se refiere al tipo de veh�culo (ponemos un numero para
 %         distinguir el tipo de veh�culo. De poner un nombre se 
 %         formar�an vectores de String, algo que no queremos.)
 %  ca --> se refiere a la cantidad de asientos del veh�culo.
 %  fm --> se refiere a la frecuencia m�nima para ese tipo de veh�culo.
 %  fM --> se refiere a la frecuencia m�xima para ese tipo de veh�culo.
 %  cm --> se refiere a la cantidad m�nima de ese tipo de veh�culo.
 %  cM --> se refiere a la cantidad m�xima de ese tipo de veh�culo.
    
    model.C1=C1;
    model.C2=C2;
    model.dij=dij;
    model.tij=tij;
    model.fmin=fmin;
    model.Qkmax=Qkmax;
    model.LFmax=LFmax;
    model.W=W;
    model.pos = randi([1 10]);
    model.McombVehiculos=CVMVehiculos;   %Matriz n-dimensional de combinaciones de los veh�culos.
    model.VectCantAsientos = MatDatVehic(:,1);
    model.MatCantComb = VMVehiculos;

end
 

