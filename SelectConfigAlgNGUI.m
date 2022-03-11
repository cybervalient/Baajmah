function config=SelectConfigAlgNGUI(path_n,fileName)

    FullFileName=[path_n fileName];
    
    data=load(FullFileName);
    
    config=data.Config;

end