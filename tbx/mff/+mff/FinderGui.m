classdef FinderGui < handle
    
    properties
        Parent
        Input
        Output
        Index
        Query = ''
        JavaOutput
        Results = {}
    end
    
    methods
        function obj = FinderGui()
            obj.Parent = figure('Units', 'normalized', ...
                        'Position', [0.3, 0.3, 0.4, 0.4], ...
                        'ToolBar', 'none', ...
                        'MenuBar', 'none', ...
                        'CloseRequestFcn', @(~, ~) obj.delete());
            obj.Parent.Units = 'pixels';
            pixelPosition = obj.Parent.Position;
            wd = pwd();
            obj.Index = mff.indexDirectory(wd);
            obj.Index = strrep(obj.Index, wd, '');
            % remove any leading slashes
            obj.Index = strip(obj.Index, 'left', '/');
            obj.Index = strip(obj.Index, 'left', '\');
            obj.Results = obj.Index;
            obj.Input = uicontrol('Parent', obj.Parent, ...
                'Style', 'edit', ...
                'Units', 'pixels', ...
                'FontSize', 14, ...
                'Position', [0, pixelPosition(4) - 50, pixelPosition(3), 50]);
            jInput = findjobj(obj.Input);
            jInput.KeyPressedCallback = @obj.update;
            obj.Output = uicontrol('Parent', obj.Parent, ...
                'Style', 'listbox', ...
                'String', obj.Index, ...
                'Units', 'pixels', ...
                'FontSize', 14, ...
                'Enable', 'inactive', ...
                'Position', [0, 0, pixelPosition(3), pixelPosition(4)-50]);
            obj.hideScrollbars();
            figure(obj.Parent);
            uicontrol(obj.Input)
        end
        
        function delete(obj)
            delete(obj.Parent);
        end
        
        function update(obj, src, event)
            switch event.getKeyCode()
                case 40 % down
                    maxValue = numel(obj.Output.String);
                    obj.Output.Value = min(obj.Output.Value + 1, maxValue);
                case 38 % up
                    obj.Output.Value = max(obj.Output.Value - 1, 1);
                case 10 % return
                    currentResult = obj.Results{obj.Output.Value};
                    edit(currentResult);
                    close(obj.Parent);
                case 27 % esc
                    close(obj.Parent);
                otherwise
                    obj.Query = src.getText;
                    result = mff.fuzzyMatch(obj.Query, obj.Index);
                    obj.Results = result.allText;
                    obj.Output.String = result.allText;
                    obj.hideScrollbars();
            end
        end
    end
    
    methods (Access = private)
        function hideScrollbars(obj)
            if isempty(obj.JavaOutput)
                obj.JavaOutput = findjobj(obj.Output);
            end
            pause(0.01);
            obj.JavaOutput.setVerticalScrollBarPolicy(javax.swing.ScrollPaneConstants.VERTICAL_SCROLLBAR_NEVER);
            obj.JavaOutput.setHorizontalScrollBarPolicy(javax.swing.ScrollPaneConstants.HORIZONTAL_SCROLLBAR_NEVER);
        end
    end
end