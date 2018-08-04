classdef gui < handle
    
    properties
        Input
        Output
        Index
        Query = ''
    end
    
    methods
        function obj = gui()
            f = figure('Units', 'normalized', ...
                        'Position', [0.3, 0.3, 0.4, 0.4]);
            f.Units = 'pixels';
            pixelPosition = f.Position;
            wd = pwd();
            obj.Index = indexDirectory(wd);
            obj.Index = strrep(obj.Index, wd, '');
            obj.Input = uicontrol('Parent', f, ...
                'Style', 'edit', ...
                'Units', 'pixels', ...
                'FontSize', 14, ...
                'Position', [0, pixelPosition(4) - 50, pixelPosition(3), 50]);
            jInput = findjobj(obj.Input);
            jInput.KeyPressedCallback = @obj.update;
            obj.Output = uicontrol('Parent', f, ...
                'Style', 'listbox', ...
                'String', {'Start typing'}, ...
                'Units', 'pixels', ...
                'FontSize', 14, ...
                'Enable', 'inactive', ...
                'Position', [0, 0, pixelPosition(3), pixelPosition(4)-50]);
            jScrollPane = findjobj(obj.Output);
 
            jScrollPane.setVerticalScrollBarPolicy(javax.swing.ScrollPaneConstants.VERTICAL_SCROLLBAR_NEVER);
            jScrollPane.setHorizontalScrollBarPolicy(javax.swing.ScrollPaneConstants.HORIZONTAL_SCROLLBAR_NEVER);

        end
        
        function update(obj, src, event)
            if event.getKeyCode == 40 % down
                maxValue = numel(obj.Output.String);
                obj.Output.Value = min(obj.Output.Value + 1, maxValue);
            elseif event.getKeyCode == 38 % up
                obj.Output.Value = max(obj.Output.Value - 1, 1);
            elseif event.getKeyCode == 10 % return
                return
            else
                obj.Query = src.getText;
                result = fuzzyMatch(obj.Query, obj.Index)
                obj.Output.String = result.allText;
            end
        end
    end
end