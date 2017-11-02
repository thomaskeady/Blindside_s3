classdef PlotClass < handle % tbh idk what < handle means but it made a warning go away
    properties(SetAccess = public)
        % Plot handle
        FigureHandle
        
        % Plot axes
        ax
        
    end
    
    properties(SetAccess = private)
        
        
        % Gray box in center representing vehicle
        Vehicle
        
        % Holds all the particles
        Particles
        
        % Best guess of worker position (prediction)
        BestGuess
        
        % Actual position (if known)
        ActualPosition
        
        % For circles when simulating
        CirclePlots
        
        
    end
    
    methods
        %function obj = PlotClass(x_dist, y_dist, bound, isLive)
        function obj = PlotClass() 
            
            % Do nothing?
            
            
        end % Constructor
        
        function begin(obj, x_dist, y_dist, sensorPositions, bound, isLive)
            obj.FigureHandle = figure('Name', 'Particle Filter');
            
            NUM_RECEIVERS = length(sensorPositions);
            
            %disp('Why no figure here?');
            %pause;
            
            obj.ax = axes(obj.FigureHandle);
            cla(obj.ax);
            
            %disp('between cla and position');
            
            % customize the figure
            obj.FigureHandle.Position = [100 100 1000 500];
            axis(obj.ax, 'equal');
            xlim(obj.ax, [-(bound+1),bound+1]);
            ylim(obj.ax, [-(bound+1),bound+1]);
            grid(obj.ax, 'on');
            box(obj.ax, 'on');    
            
            hold(obj.ax, 'on')
            
            obj.Vehicle = rectangle(obj.ax, 'position', [-x_dist, -y_dist, 2*x_dist, 2*y_dist], 'facecolor', [0.5, 0.5, 0.5]);
            
            obj.Particles = scatter(obj.ax, 0,0,'MarkerEdgeColor','b', 'Marker', '.');
            
            obj.BestGuess = plot(obj.ax, 0,0,'rs-', 'MarkerSize', 10, 'LineWidth', 1.5); % best guess of pose
            
            %if (isLive) 
            %    obj.ActualPosition = plot(obj.ax, 0,0,'gs-', 'MarkerSize', 10, 'LineWidth', 1.5); % Actual worker location
            %    disp('isLive = true');
            %end  % Else leave it uninitialized % Not anymore with ground truth!!
            
            obj.ActualPosition = plot(obj.ax, 0,0,'gs-', 'MarkerSize', 10, 'LineWidth', 1.5); % Actual worker location
            %disp('isLive = true');
            
            obj.CirclePlots = cell(NUM_RECEIVERS, 1);

            theta = linspace(0, 2*pi);

            for i = 1:NUM_RECEIVERS
                obj.CirclePlots{i} = plot(obj.ax, 0*cos(theta) + sensorPositions(1, i), 0*sin(theta) + sensorPositions(2, i), 'y');
            end
            %disp('exiting begin');
        end
        
        
        function updatePlotSim(obj, particleFilter, t, measurement, sensorPositions, currentBestGuess, actualPosition)
            
            %disp('updatePLot called');
            
            particles = particleFilter.Particles;
            obj.Particles.XData = particles(1:end,1);
            obj.Particles.YData = particles(1:end,2);
            
            obj.BestGuess.XData = currentBestGuess(1);
            obj.BestGuess.YData = currentBestGuess(2);
            
            obj.ActualPosition.XData = actualPosition(1);
            obj.ActualPosition.YData = actualPosition(2);
            
            %BRING THIS BACK BY ADDING MEASUREMENTS TO INPUTS
            theta = linspace(0, 2*pi); 
            for i = 1:length(measurement)
                obj.CirclePlots{i}.XData = measurement(1,i)*cos(theta) ...
                    + sensorPositions(1,i);
                obj.CirclePlots{i}.YData = measurement(1,i)*sin(theta) ...
                    + sensorPositions(2,i);
            end


            %obj.CirclePlots.XData = measurement(

            obj.ax = get(obj.FigureHandle, 'currentaxes');
            title(obj.ax, ['t = ', num2str(t)]);
            
            %disp('end updatePlot');
            
            pause(0.025);
            
        end
        
        
        function updatePlotLive(obj, particleFilter, currentBestGuess)
            
            particles = particleFilter.Particles;
            obj.Particles.XData = particles(1:end,1);
            obj.Particles.YData = particles(1:end,2);
            
            obj.BestGuess.XData = currentBestGuess(1);
            obj.BestGuess.YData = currentBestGuess(2);
                        
            
        end
        
        
    end
    
end