function uninstall()
    folderRoot = fileparts(mfilename('fullpath'));
    javarmpath(fullfile(folderRoot, 'tbx', 'mff', 'extern', 'java', 'commons-text-1.3.jar'));
    rmpath(fullfile(folderRoot, 'tbx', 'mff'));
    rmpath(fullfile(folderRoot, 'tbx', 'mff', 'extern', 'findjobj'));
end
