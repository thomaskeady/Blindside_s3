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

stateBounds = [
    -6, 6;
    -8, 8];

initialize(pf, 1000, stateBounds);

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
xlim(ax, [-0.1,12]);
ylim(ax, [-1,4]);
grid(ax, 'on');
box(ax, 'on');         

hold(ax, 'on')
plotHParticles = scatter(ax, 0,0,'MarkerEdgeColor','g', 'Marker', '.');









% Everything here is for the circularly moving worker
radius = 3.5;
noise = .1; % noise = random gaussian * dist * this
rng('default'); % for repeatable result

while simulationTime < 20 % if time is not up
    
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
    
    % Predict
    [statePred, covPred] = predict(pf);

    % Correct % originally had a transpose on the measurement?
    [stateCorrected, covCorrected] = correct(pf, measurement, sensorPositions);
    
    
    % Update plot
    if ~isempty(get(groot,'CurrentFigure')) % if figure is not prematurely killed
        updatePlot(pf, stateCorrected, simulationTime, plotHParticles, plotFigureHandle);
    else
        break
    end
    
    waitfor(r);
    
    % Update simulation time
    simulationTime = simulationTime + dt;
    
end





disp('Done');

