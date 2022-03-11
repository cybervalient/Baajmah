function config=SelectConfigAlg()

    Filter={'*.mat','MAT Files (*.mat)'
            '*.*','All Files (*.*)'};

    [FileName, FilePath]=uigetfile(Filter,'Seleccionar el archivo de configuracion ...');
    
    if FileName==0
        config=[];
        return;
    end
    
    FullFileName=[FilePath FileName];
    
    data=load(FullFileName);
    
    config=data.Config;

end