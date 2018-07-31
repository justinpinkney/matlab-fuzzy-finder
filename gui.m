f = figure
tic

query = 'sub';
files = dir('~');
allText = {files.name};
control = uicontrol('Parent', f, ...
    'Style', 'edit', ...
    'KeyPressFcn', @(src, ~) fuzzyMatch(src.String, allText));