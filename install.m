function install()
    folderRoot = fileparts(mfilename('fullpath'));
    javaaddpath(fullfile(folderRoot, 'tbx', 'mff', 'extern', 'java', 'commons-text-1.3.jar'));
    addpath(fullfile(folderRoot, 'tbx', 'mff'));
    addpath(fullfile(folderRoot, 'tbx', 'mff', 'extern', 'findjobj'));
end
