%function updatePlot(obj, particleFilter, currentBestGuess, t)
function updatePlot(particleFilter, currentBestGuess, t, plotHParticles, plotFigureHandle, plotHBestGuesses, plotActualPosition, worker)
    % updatePlot

    %obj.Cnt1 = obj.Cnt1 + 1;           

    % render particles
    particles = particleFilter.Particles;
    %if obj.isCarInRoofedArea
    %    obj.HParticles.MarkerEdgeColor = [1, 0.5, 0]; % orange
    %else
    %    obj.HParticles.MarkerEdgeColor = 'g';
    plotHParticles.MarkerEdgeColor = 'g';
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

    ax = get(plotFigureHandle, 'currentaxes');
    title(ax, ['t = ', num2str(t)]);

%     % capture snapshots for time frame 101 and 265
%     if floor(t/obj.Dt) == 101 
%         snapnow
%     end
% 
%     if floor(t/obj.Dt) == 265
%         snapnow
%     end
end