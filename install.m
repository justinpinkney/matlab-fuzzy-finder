function install()
    folderRoot = fileparts(mfilename('fullpath'));
    javaaddpath(fullfile(folderRoot, 'java', 'commons-text-1.3.jar'));
    addpath(fullfile(folderRoot, 'extern'));
end
