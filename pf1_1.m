clear all
close all

% Start with positions of the sensors

sensorPositions = [
    -1, -2;
    1, -2;
    1, 0;
    1, 2;
    -1, 2;
    -1, 0];

%disp(sensorPositions);

%plot(sensors(:, 1), sensors(:, 2)); % Plots the rectangle

% Make the pf
pf = robotics.ParticleFilter;


bound = 8;
stateBounds = [
    -bound, bound;
    -bound, bound];

initialPose = [3.5, 0];
%initialize(pf, 1000, stateBounds);
initialize(pf, 1000, initialPose, eye(2));

% INVESTIGATE WHETHER THESE NEED TO TO CHANGE
pf.StateEstimationMethod = 'mean';
pf.ResamplingMethod = 'systematic';

% In separate files for now
pf.StateTransitionFcn = @stf1_1;
pf.MeasurementLikelihoodFcn = @mlf1_1;

% Time step
dt = 0.1; % in seconds

r = robotics.Rate(1/dt);
reset(r); % Example says "% Reset the fixed-rate object"

simulationTime = 0;

% Plot stuff stolen from ExampleHelperCarBot
plotFigureHandle = figure('Name', 'Particle Filter');
% clear the figure
ax = axes(plotFigureHandle);
cla(ax)

% customize the figure
plotFigureHandle.Position = [100 100 1000 500];
axis(ax, 'equal');
xlim(ax, [-(bound+1),bound+1]);
ylim(ax, [-(bound+1),bound+1]);
grid(ax, 'on');
box(ax, 'on');         

hold(ax, 'on')

HRoofedArea = rectangle(ax, 'position', [-1,-2,2,4],'facecolor',[0.5 0.5 0.5]); % roofed area (no measurement)

plotHParticles = scatter(ax, 0,0,'MarkerEdgeColor','b', 'Marker', '.');

plotHBestGuesses = plot(ax, 0,0,'rs-'); % best guess of pose

plotActualPosition = plot(ax, 0,0,'gs-'); % Actual worker location

% Everything here is for the circularly moving worker
radius = 0.5;
noise = 3; % noise = random gaussian * dist * this
rng('default'); % for repeatable result

while simulationTime < 30 % if time is not up
    
    % Predict
    [statePred, covPred] = predict(pf, noise);
    
    
    % Create circular path for worker
    worker(1) = radius * cos(simulationTime);
    worker(2) = radius * sin(simulationTime);
    
    measurement(1) = sqrt( ...
        (sensorPositions(1,1) - worker(1))^2 + ...
        (sensorPositions(1,2) - worker(2))^2 );
    
    measurement(2) = sqrt( ...
        (sensorPositions(2,1) - worker(1))^2 + ...
        (sensorPositions(2,2) - worker(2))^2 );
    
    measurement(3) = sqrt( ...
        (sensorPositions(3,1) - worker(1))^2 + ...
        (sensorPositions(3,2) - worker(2))^2 );
    
    measurement(4) = sqrt( ...
        (sensorPositions(4,1) - worker(1))^2 + ...
        (sensorPositions(4,2) - worker(2))^2 );
    
    measurement(5) = sqrt( ...
        (sensorPositions(5,1) - worker(1))^2 + ...
        (sensorPositions(5,2) - worker(2))^2 );
    
    measurement(6) = sqrt( ...
        (sensorPositions(6,1) - worker(1))^2 + ...
        (sensorPositions(6,2) - worker(2))^2 );
    
    % Add noise
    measurement + ((randn(1,1) * noise).*measurement);
    
    %disp(measurement); % Post noise
    
    % Correct % originally had a transpose on the measurement?
    [stateCorrected, covCorrected] = correct(pf, measurement, sensorPositions);
    
    
    % Update plot
    if ~isempty(get(groot,'CurrentFigure')) % if figure is not prematurely killed
        updatePlot(pf, stateCorrected, simulationTime, plotHParticles, plotFigureHandle, plotHBestGuesses, plotActualPosition, worker);
    else
        break
    end
    
    waitfor(r);
    
    % Update simulation time
    simulationTime = simulationTime + dt;
    
end





disp('Done');

