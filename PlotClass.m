classdef PlotClass 
    properties(SetAccess = public)
        
        
    end
    
    properties(SetAccess = private)
        % Plot handle
        FigureHandle
        
        % Gray box in center representing vehicle
        Vehicle
        
        
        
    end
    
    methods
        function obj = PlotClass(x_dist, y_dist, bound)
            obj.FigureHandle = figure('Name', 'Particle Filter');
            ax = axes(obj.FigureHandle);
            cla(ax);
            
            % customize the figure
            obj.FigureHandle.Position = [100 100 1000 500];
            axis(ax, 'equal');
            xlim(ax, [-(bound+1),bound+1]);
            ylim(ax, [-(bound+1),bound+1]);
            grid(ax, 'on');
            box(ax, 'on');    
            
            hold(ax, 'on')
            
            obj.Vehicle = rectangle(ax, 'position', [-x_dist, -y_dist, 2*x_dist, 2*y_dist], 'facecolor', [0.5, 0.5, 0.5]);
            
            
            
        end
        
        
        
        
    end
    
end