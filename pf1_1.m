% Start with positions of the sensors

sensorPositions = [
    -1, -2;
    1, -2;
    1, 0;
    1, 2;
    -1, 2;
    -1, 0];

disp(sensorPositions);

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

% Everything here is for the circularly moving worker
radius = 3.5;
noise = .1; % noise = random gaussian * dist * this

while simulationTime < 20 % if time is not up
    
    % Create circular path for worker
    worker(1) = radius * cos(simulationTime);
    worker(2) = radius * sin(simulationTime);
    
    measurement(1) = sqrt( ...
        (sensorPosition(1,1) - worker(1))^2 + ...
        (sensorPosition(1,2) - worker(2))^2 );
    
    measurement(2) = sqrt( ...
        (sensorPosition(2,1) - worker(1))^2 + ...
        (sensorPosition(2,2) - worker(2))^2 );
    
    measurement(3) = sqrt( ...
        (sensorPosition(3,1) - worker(1))^2 + ...
        (sensorPosition(3,2) - worker(2))^2 );
    
    measurement(4) = sqrt( ...
        (sensorPosition(4,1) - worker(1))^2 + ...
        (sensorPosition(4,2) - worker(2))^2 );
    
    measurement(5) = sqrt( ...
        (sensorPosition(5,1) - worker(1))^2 + ...
        (sensorPosition(5,2) - worker(2))^2 );
    
    measurement(6) = sqrt( ...
        (sensorPosition(6,1) - worker(1))^2 + ...
        (sensorPosition(6,2) - worker(2))^2 );
    
    % Add noise
    measurement + ((randn(1,1) * noise).*measurement);
    
    % Predict
    [statePred, covPred] = predict(pf, dt);

    
end





disp('Done');

