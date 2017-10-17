%function updatePlot(obj, particleFilter, currentBestGuess, t)
% function updatePlot(particleFilter, currentBestGuess, t, plotHParticles, plotFigureHandle, plotHBestGuesses, plotActualPosition, worker, sensorPositions, measurement)
function updatePlot(particleFilter, currentBestGuess, t, plotHParticles, plotFigureHandle, plotHBestGuesses, plotActualPosition, worker, sensorPositions, measurement, circlePlots)
% updatePlot

    %obj.Cnt1 = obj.Cnt1 + 1;           

    % render particles
    particles = particleFilter.Particles;
    %if obj.isCarInRoofedArea
    %    obj.HParticles.MarkerEdgeColor = [1, 0.5, 0]; % orange
    %else
    %    obj.HParticles.MarkerEdgeColor = 'g';
    plotHParticles.MarkerEdgeColor = 'b';
    %end
    plotHParticles.XData = particles(1:end,1);
    plotHParticles.YData = particles(1:end,2);   

%     if obj.Cnt1 == 8
%         obj.BGs = [obj.BGs; currentBestGuess];
%         obj.Cnt1 = 0;
%         % draw best estimated robot trace (by observer)
%         obj.HBestGuesses.XData = obj.BGs(:,1);
%         obj.HBestGuesses.YData = obj.BGs(:,2);
%     end

    plotHBestGuesses.XData = currentBestGuess(1);
    plotHBestGuesses.YData = currentBestGuess(2);

    plotActualPosition.XData = worker(1);
    plotActualPosition.YData = worker(2);
    
%     % draw car rear axle center
%     obj.HCenter.XData = obj.Pose(1);
%     obj.HCenter.YData = obj.Pose(2);
% 
%     % draw car trajectory
%     obj.HTrajectory.XData = obj.Trace(1,:);
%     obj.HTrajectory.YData = obj.Trace(2,:);
% 
%     % draw car-like robot
%     obj.drawCarBot();

    theta = linspace(0, 2*pi);
%     for s = 1:length(sensorPositions)
%         plot(measurement(s)*cos(theta) + sensorPositions(s, 1), ...
%              measurement(s)*sin(theta) + sensorPositions(s, 2), 'y');
%         
%     end
% %     
%     circlePlots.XData = measurement*cos(theta) ...
%         + sensorPositions(:, 1);
%     circlePlots.YData = measurement*sin(theta) ...
%         + sensorPositions(:, 2);

    for i = 1:length(measurement)
        circlePlots{i}.XData = measurement(i,1)*cos(theta) ...
            + sensorPositions(i,1);
        circlePlots{i}.YData = measurement(i,1)*sin(theta) ...
            + sensorPositions(i,2);
    end
    
    ax = get(plotFigureHandle, 'currentaxes');
    title(ax, ['t = ', num2str(t)]);


end