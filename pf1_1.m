clear all
close all
fclose('all');
delete(instrfindall) % For open serial ports


% Start with positions of the sensors

% sensorPositions = [
%      -1, -2;
%      1, -2;
%      1, 0;
%      1, 2;
%      -1, 2;
%      -1, 0];


sideDist = 1.52; % m, 2x this distance is length of vehicle
halfwidth = 1.22; %m, 2x this is width of vehicle

sensorPositions = [
    -halfwidth, -sideDist;
    -halfwidth, 0;
    -halfwidth, sideDist;
    halfwidth, sideDist;
    halfwidth, 0;
    halfwidth, -sideDist];
    

%disp(sensorPositions);

% Should print sensor positions to file too

%plot(sensors(:, 1), sensors(:, 2)); % Plots the rectangle

% Receiver addresses
NUM_RECEIVERS = 6; % Should be equal to length(sensorPositions)
START_RECEIVER = 2; % The first one that will get a successful read

disp('Opening receivers')

duinos = cell(NUM_RECEIVERS,1);
% duinos{4} = '/dev/tty.usbserial-DN00CSPC';%
% duinos{3} = '/dev/tty.usbserial-DN00CZUI';%
% duinos{2} = '/dev/tty.usbserial-DN00B9FJ';%%
% duinos{5} = '/dev/tty.usbserial-DN00D2RN';%
% duinos{6} = '/dev/tty.usbserial-DN00D3MA';%
% duinos{1} = '/dev/tty.usbserial-DN00D41X';%

duinos{1} = '/dev/tty.usbserial-DN00D3MA';%
duinos{2} = '/dev/tty.usbserial-DN00D2RN';%
duinos{3} = '/dev/tty.usbserial-DN00CSPC';%
duinos{4} = '/dev/tty.usbserial-DN00B9FJ';%
duinos{5} = '/dev/tty.usbserial-DN00D41X';%
duinos{6} = '/dev/tty.usbserial-DN00CVZK';%

ports = cell(NUM_RECEIVERS, 1);

% % Do we still have to do this janky first one outside the loop?
%l%ports{1} = serial(duinos{1}, 'BaudRate', 115200);
%l%fopen(ports{1});
%l%set(ports{1}, 'Timeout', 0.1);
%l%set(ports{1}, 'Timeout', 2);

for i = START_RECEIVER:NUM_RECEIVERS
    %disp(duinos{i});
    %disp('next');
    %l%ports{i} = serial(duinos{i},'BaudRate',115200);
    %l%fopen(ports{i});
    %l%set(ports{i}, 'Timeout', 2);
    
end

% 
%for i = 1:length(duinos)
% for i = START_RECEIVER:NUM_RECEIVERS+1
%     %disp(duinos{i});
%     %disp('next');
%     ports{i-1} = serial(duinos{i-1},'BaudRate',115200);
%     fopen(ports{i-1});
%     set(ports{i-1}, 'Timeout', 2);
%     
% end

%disp(ports);

readings = cell(NUM_RECEIVERS, 1);

trash = 0;

for t = 1:5 % Clearing startup glitches
    for i = 1:NUM_RECEIVERS
        
        %l%fwrite(ports{i}, 'A');
        %trash = fscanf(ports{i}, '%d');
        %l%readings{i} = fscanf(ports{i}, '%d');
        
    end
end

disp(class(cell2mat(readings)));
disp(cell2mat(readings));

disp('done with trash')


% For data logging
location = 'H224B';
fname = sprintf('data/data_outside_%s.csv', datestr(now,'mm-dd-yyyy_HH-MM-SS'));
fid = fopen(fname, 'a+');
fprintf(fid, '%f,%f,%f,%f,%f,%f\n', sensorPositions(:, 1)); % print all x vals
fprintf(fid, '%f,%f,%f,%f,%f,%f\n', sensorPositions(:, 2)); % print all y vals
%fprintf(fid, '%d,%d,%d,%d,%d,%d\n', sensorPositions(1, 1), sensorPositions(1, 2), sensorPositions(1, 3), sensorPositions(1, 4), sensorPositions(1, 5), sensorPositions(1, 6)); % print all x vals
%fprintf(fid, '%d,%d,%d,%d,%d,%d\n', sensorPositions(2, 1), sensorPositions(2, 2), sensorPositions(2, 3), sensorPositions(2, 4), sensorPositions(2, 5), sensorPositions(2, 6)); % print all y vals

% Make the pf
pf = robotics.ParticleFilter;

NUM_PARTICLES = 2000;

bound = 8;
stateBounds = [
    -bound, bound;
    -bound, bound];
initialize(pf, NUM_PARTICLES, stateBounds);

%initialPose = [3.5, 0];
%initialize(pf, numParticles, initialPose, eye(2));

% INVESTIGATE WHETHER THESE NEED TO TO CHANGE
%pf.StateEstimationMethod = 'mean';
pf.StateEstimationMethod = 'maxweight';
pf.ResamplingMethod = 'systematic';

% In separate files for now
pf.StateTransitionFcn = @stf1_1;
pf.MeasurementLikelihoodFcn = @mlf1_1;

% Time step
DT = 0.5; % in seconds

%r = robotics.Rate(1/dt);
%reset(r); % Example says "% Reset the fixed-rate object"

simulationTime = 0;

% Plot stuff stolen from ExampleHelperCarBot
plotFigureHandle = figure('Name', 'Particle Filter');
% clear the figure

disp('between figure and axes');
%pause; % Window with no axes (makes sense lol)

ax = axes(plotFigureHandle);
cla(ax)

disp('between cla and .Position');
%pause; % Little baby plot with no formatting

% customize the figure
plotFigureHandle.Position = [100 100 1000 500];
axis(ax, 'equal');
xlim(ax, [-(bound+1),bound+1]);
ylim(ax, [-(bound+1),bound+1]);
grid(ax, 'on');
box(ax, 'on');         

disp('between box and hold');
%pause; % plot appears, no box

hold(ax, 'on')

HRoofedArea = rectangle(ax, 'position', [-1,-2,2,4],'facecolor',[0.5 0.5 0.5]); % roofed area (no measurement)

plotHParticles = scatter(ax, 0,0,'MarkerEdgeColor','c', 'Marker', '.');

plotHBestGuesses = plot(ax, 0,0,'rs-', 'MarkerSize', 10, 'LineWidth', 1.5); % best guess of pose

plotActualPosition = plot(ax, 0,0,'gs-', 'MarkerSize', 10, 'LineWidth', 1.5); % Actual worker location

circlePlots = cell(NUM_RECEIVERS, 1);

theta = linspace(0, 2*pi);

for i = 1:NUM_RECEIVERS
    circlePlots{i} = plot(ax, 0*cos(theta) + sensorPositions(i, 1), 0*sin(theta) + sensorPositions(i, 2), 'y');
end


RSSI_TO_M_COEFF = 0.00482998;
RSSI_TO_M_EXP = -0.104954;

% Everything here is for the circularly moving worker
RADIUS = 4.5;
NOISE = 3; % noise = random gaussian * dist * this
SPEED = 0.5;   % Scales how quickly they move
rng('default'); % for repeatable result
worker(1) = 0;
worker(2) = 0;

while simulationTime < 50 % if time is not up
    
    disp('==== STARTED NEXT LOOP ====');
    
    % Predict
    [statePred, covPred] = predict(pf, NOISE);
    
    % Real measurements now!
    
    measurement = zeros(length(sensorPositions), 1);
    
    for i = 1:NUM_RECEIVERS
        
        %l%fwrite(ports{i}, 'A');
        %l%readings{i} = fscanf(ports{i}, '%d');
        %l%disp( readings{i});
        %l%readings{i} = RSSI_TO_M_COEFF * exp(RSSI_TO_M_EXP * readings{i});
        
        
    end    
    
    %l%measurement = cell2mat(readings);
    
    fprintf(fid, '%f,%f,%f,%f,%f,%f,', measurement);
    fprintf(fid, '\n');
    
    disp(readings);
    disp(measurement);
    
    % Correct % originally had a transpose on the measurement?
    [stateCorrected, covCorrected] = correct(pf, measurement, sensorPositions);
    
    
    % Update plot
    if ~isempty(get(groot,'CurrentFigure')) % if figure is not prematurely killed
        %updatePlot(pf, stateCorrected, simulationTime, plotHParticles, plotFigureHandle, plotHBestGuesses, plotActualPosition, worker);
        updatePlot(pf, stateCorrected, simulationTime, plotHParticles, plotFigureHandle, plotHBestGuesses, plotActualPosition, worker, sensorPositions, measurement, circlePlots);
    else
        break
    end
    
    %waitfor(r);
    pause;
    
    
    % Update simulation time
    simulationTime = simulationTime + DT;
    
end



delete(instrfindall);
%clear all;

fclose(fid);

disp('Done');

