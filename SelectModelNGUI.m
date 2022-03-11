function model=SelectModelNGUI(path_n,fileName)

%     Filter={'*.mat','MAT Files (*.mat)'
%             '*.*','All Files (*.*)'};
% 
%     [FileName, FilePath]=uigetfile(Filter,'Select Model ...');
%     
%     if FileName==0
%         model=[];
%         return;
%     end
%     
    FullFileName=[path_n fileName];
    
    data=load(FullFileName);
    
    model=data.model;

end