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
                'Position', [0, 0, 1, 0.5]);
            jInput = findjobj(obj.Input);
            jInput.KeyTypedCallback = @obj.update;
            obj.Output = uicontrol('Parent', f, ...
                'Style', 'listbox', ...
                'Units', 'normalized', ...
                'Enable', 'off', ...
                'Position', [0, 0.5, 1, 0.5]);
        end
        
        function update(obj, src, event)
            obj.Query = src.getText;
            result = fuzzyMatch(obj.Query, obj.Index)
            obj.Output.String = result.allText;
            
        end
    end
end