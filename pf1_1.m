% Start with positions of the sensors

sensors = [
    -1, -2;
    1, -2;
    1, 0;
    1, 2;
    -1, 2;
    -1, 0];

disp(sensors);

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

while simulationTime < 20 % if time is not up
    
    
    
end



disp('Done');

