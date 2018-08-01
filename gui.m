classdef gui < handle
    
    properties
        Input
        Output
        Index
        Query = ''
    end
    
    methods
        function obj = gui()
            f = figure;
            wd = pwd();
            obj.Index = indexDirectory(wd);
            obj.Index = strrep(obj.Index, wd, '');
            obj.Input = uicontrol('Parent', f, ...
                'Style', 'edit', ...
                'Units', 'normalized', ...
                'Position', [0, 0, 1, 0.5], ...
                'KeyPressFcn', @obj.update);
            obj.Output = uicontrol('Parent', f, ...
                'Style', 'listbox', ...
                'Units', 'normalized', ...
                'Enable', 'off', ...
                'Position', [0, 0.5, 1, 0.5]);
        end
        
        function update(obj, src, event)
            if strcmp(event.Key, 'backspace')
                if ~isempty(obj.Query)
                    obj.Query = obj.Query(1:end-1);
                end
            else
                obj.Query = [obj.Query, event.Character];
            end
            result = fuzzyMatch(obj.Query, obj.Index)
            obj.Output.String = result.allText;
            
        end
    end
end