function index = indexDirectory(directory)
    query = fullfile(directory, '**/*.m');
    files = dir(query);
    index = arrayfun(@(x) fullfile(x.folder, x.name), files, ...
                    'UniformOutput', false);
end
