clc;
clear;
%este

% Parámetros de entrada:
%
%   C1 y C2 --> factores de conversión y pesos relativos de
%               los términos de la función objetivo.
%   dij --> demanda total de transportación.
%   tij --> Tiempo total del recorrido de la ruta.
%   file --> ruta del archivo excel con el juego de datos.
%
% Parámetros de restricciones,
%   fmin --> frecuencia mínima.
%   Qkmax --> máximo flujo en la ruta.
%   LFmax --> máximo factor de carga permitido.
%   W --> tamaño de la flota.


C1 = 0.35;
C2 = 2.13;
dij = 1.5;
tij = 4.5;

fmin = 0.15;
Qkmax = 18;
LFmax = .253;
W = 5;

% iteraciones = 0;


% Tabla de vehículos

 %  Matrix formada por vectores con los datos de los vehículos
 %  estructurados de la siguiente forma: [v ca fm fM cm cM] dónde:
 %  v --> se refiere al tipo de vehículo (ponemos un numero para
 %          distinguir el tipo de vehículo. De poner un nombre se 
 %          formarían vectores de String, algo que no queremos.)
 %  ca --> se refiere a la cantidad de asientos del vehículo.
 %  fm --> se refiere a la frecuencia mínima para ese tipo de vehículo.
 %  fM --> se refiere a la frecuencia máxima para ese tipo de vehículo.
 %  cm --> se refiere a la cantidad mínima de ese tipo de vehículo.
 %  cM --> se refiere a la cantidad máxima de ese tipo de vehículo.
 
                           % 3 5 10 15
%MVehiculos --> MatDatVehic  %% Matriz de datos de los vehículos                            
                           
MatDatVehic = [1 25 .1 2 0 120;   % Paz 25
              2 28 .1 2 0 120;   % Diana 28
             % 3 30 .4 20 1 6;   
%               3 25 .4 2 0 6;
%               3 25 .4 2 0 6;
              4 32 .1 2 0 123];  % Gran Porte 32
    
beep;
tic;
TTVMVehiculos = MatDatVehic(:,3:end);
VMVehiculos= zeros(size(MatDatVehic,1),1);
nVMVehiculos = size(MatDatVehic,1);

%CVect  --> CantVectXVehic  %%Vector Cantidad de combinaciones por tipo de vehículo
VectCantCombXVehic = cell(1, size(MatDatVehic,1));

for i =1:nVMVehiculos
    VMVehiculos(i) =  numel(MatDatVehic(i,3):0.1:MatDatVehic(i,4)) * numel(MatDatVehic(i,5):1:MatDatVehic(i,6));
    VectCantCombXVehic(i)={1:1:VMVehiculos(i)};
end    
    
CVMVehiculos = zeros(max(VMVehiculos),2,nVMVehiculos);

for i =1 :nVMVehiculos
    TPTVMVehiculos = {MatDatVehic(i,3):0.1:MatDatVehic(i,4),MatDatVehic(i,5):1:MatDatVehic(i,6)};
    VX=cell(1,numel(TPTVMVehiculos));
    [VX{:}]=ndgrid(TPTVMVehiculos{:});
    VX=cellfun(@(X) reshape(X,[],1),VX,'UniformOutput',false);
    VX=horzcat(VX{:});
    if not (size(VX,1) == max(VMVehiculos))
        VX(max(VMVehiculos),2)=0;
    end
    CVMVehiculos(:,:,i) = VX;
end

MM =cell(1,numel(VMVehiculos));

for i=1:size(VMVehiculos,1)
    MM(i)={divisors(VMVehiculos(i))};
end

%matriz de combinaciones  para seleccionar los elementos de las
%combinaciones por tipo de vehículos

VTTGX=cell(1,numel(MM));
[VTTGX{:}]=ndgrid(MM{:});
VTTGX=cellfun(@(X) reshape(X,[],1),VTTGX,'UniformOutput',false);
VTTGX=horzcat(VTTGX{:});

[user,sys] = memory;
M=sys.PhysicalMemory.Available;
CantidadElem = M/8;

%Buscar la mayor cantidad de combinaciones posibles de los multiplos.
MaxC =0;
VecMAxC =0;

MDDD =zeros(MultVectorial(MM),size(MM,2)+1);
for i=1:size(VTTGX,1)
    MDDD(i,1:size(VTTGX,2))=VTTGX(i,1:size(VTTGX,2));
    MDDD(i,size(MDDD,2))= MultVectorial(MDDD(i,1:size(MDDD,2)-1));

    if (MDDD(i,size(MDDD,2)) >= MaxC) && ((MDDD(i,size(MDDD,2))*(size(MatDatVehic,1)-1)) <= CantidadElem) %CElementMEMORy) 
        MaxC =  MDDD(i,size(MDDD,2));
        VecMAxC =i;
    end
end

VMaxC = MDDD(VecMAxC,1:(size(MDDD,2)-1)); 
VMCrec = VMVehiculos'./VMaxC;  
VAct = zeros(1,size(VMVehiculos,1));

MatMinimo=zeros(1,((size(VMVehiculos,1)*3)+11));
% pos = MatMinimo(1,size(MatMinimo,2)-1)
MatMinimo(1,size(MatMinimo,2)-1) = 999999999999999999999999999999;

while sum(bsxfun(@ne,VAct,VMVehiculos')) ~= 0
    VAct = GenerarV(VMVehiculos',VAct,VMaxC,size(VAct,2),-1);
%     VAct = GenerarV(VMVehiculos',VAct,VMCrec,size(VAct,2),-1);
%     disp(VAct);
    % TODO 
    % Por cada vector VAct se deben generar las combinaciones de sus
    % elementos y a partir de esas combinaciones evaluar la funcion tomando
    % cada elementos del vector como los indices de la matriz n-dimensional
    % que está conformada por los vectores de combinaciones de los
    % parámetros de cada tipo de vehículo.
    
    VTemp = cell(1,size(VAct,2));
    for i=1:size(VAct,2)
        VTemp{i} =VAct(i)- VMaxC(i)+1 :VAct(i);
    end
    
    MComb1=cell(1,numel(VTemp));
    [MComb1{:}]=ndgrid(VTemp{:});
    MComb1=cellfun(@(X) reshape(X,[],1),MComb1,'UniformOutput',false);
    MComb1=horzcat(MComb1{:});
    
    CCVEBaajMaj = zeros(size(MComb1,2),3);
    
    % Inicializo el mínimo de la función objetivo
    Minimo = 9999999999999999999999999999999;
    Vinit =0;
 
%     for j=size(MComb1,1):-1:1
    for j=1 : size(MComb1,1)
        for k=1: size(MComb1,2)
           CCVEBaajMaj(k,:) = [CVMVehiculos(MComb1(j,k),:,k),MatDatVehic(k,2)];
        end
        VTiempos = CCVEBaajMaj(:,1)';
        VCantidadVehiculo = CCVEBaajMaj(:,2)';
        VCapacidadVehiculos = CCVEBaajMaj(:,3)';
        
%         iteraciones = iteraciones +1;
        
        if sum(VCantidadVehiculo) <= W
            fxv = VCantidadVehiculo./VTiempos;
            fk = sum(fxv);
            if isnan(fk) 
                disp(fk);
            end
            fxCAP = sum(fxv.*VCapacidadVehiculos);
            if fk >= fmin
                fxCAP = sum(fxv.*VCapacidadVehiculos);
                if Qkmax/fxCAP <= LFmax
                    if Minimo >= C1 * dij * tij + C2 *sum(VCantidadVehiculo)
                        Minimo = C1 * dij * tij + C2 *sum(VCantidadVehiculo);
                        MVMV = [reshape(CCVEBaajMaj',1,numel(CCVEBaajMaj)),sum(VCantidadVehiculo), W, fk,fmin,Qkmax,fxCAP,Qkmax/fxCAP,LFmax,C1 * dij * tij + C2 *sum(VCantidadVehiculo),Minimo,LFmax-(Qkmax/fxCAP)];
%                         disp(MatMinimo(1,size(MatMinimo,2)-1));
                        if MatMinimo(1,size(MatMinimo,2)-1) == Minimo
                            MatMinimo(size(MatMinimo,1)+1,:) = MVMV(1,:);
                        end
                        if MatMinimo(1,size(MatMinimo,2)-1) > Minimo
                           MatMinimo=zeros(1,((size(VMVehiculos,1)*3)+11));
                           MatMinimo(1,:) = MVMV(1,:); 
                        end
                    end
                end
            end
        end
    end
   
end

% Limpiar Excel
    ClearCell = strings(500,100);
    writematrix(ClearCell,'MVMV.xls','Sheet',1,'Range','A1');

% Poner encabezado EXCEL
    MVVEnc = ("");
    for h =1 : size(CCVEBaajMaj,1)
        %Frec V1	Cant V1	CAsientos V1
        if h ==1
            MVVEnc(1,size(MVVEnc,2)) = append("Frec V",convertCharsToStrings(num2str(h))); 
        else
            MVVEnc(1,size(MVVEnc,2)+1) = append("Frec V",convertCharsToStrings(num2str(h))); 
        end
        MVVEnc(1,size(MVVEnc,2)+1) = append("Cant V",convertCharsToStrings(num2str(h))); 
        MVVEnc(1,size(MVVEnc,2)+1) = append("CAsientos V",convertCharsToStrings(num2str(h))); 
    end
    
% Agregar Mínimos al Excel
    MVVEnc(1,size(MVVEnc,2)+1:size(MVVEnc,2)+11) =["Cant Veh Total","W","fk","fmin","QkMax","fxCAP","QkMax/fxCAP","LFMax","BaajMaj","Mínimo","Qk vs LF"];
    writematrix(MVVEnc,'MVMV.xls','Sheet',1,'Range','A1');
    writematrix(MatMinimo,'MVMV.xls','Sheet',1,'Range','A2');
       
   
disp('end');
disp(Minimo);
disp('');
disp(iteraciones);

toc;
beep;
%Funcion que devuelve el valor de multiplicar todos los elementos de un
%vector.

function MV = MultVectorial(V)
MV =1;
    for i=1 : numel(V)
        %
        if iscell(V(i))
            otr = length(cell2mat(V(i)));
        elseif isvector(V(i))
            otr = V(i);
        end
        MV= MV*otr;
    end
end

function GV= GenerarV(VcM,VActual,VCrecimiento,indice,aumento)
    if sum(VActual) == 0
      GV =  VCrecimiento;
      return
    end
    if (aumento == 0) || (indice == 0)
        GV = VActual;
        return;
    end
    
    if VcM(indice) - VCrecimiento(indice) ~= 0
        if (indice == 1) && (VActual(indice) + VCrecimiento(indice) == VcM(indice))
            VActual(indice) = VcM(indice);
            GV = VActual;
            return;
        end    
        if VActual(indice) + VCrecimiento(indice) > VcM(indice)
            VActual(indice) = VCrecimiento(indice);
            aumento = 1;
        else
            VActual(indice) = VActual(indice) + VCrecimiento(indice);
            aumento = 0;
        end
    end
    GV = GenerarV(VcM,VActual,VCrecimiento,indice-1,aumento);
end

