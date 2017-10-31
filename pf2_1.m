% Generic stuff
clear all
close all
fclose('all');
delete(instrfindall) % For open serial ports

% Declare # of receivers
NUM_RECEIVERS = 6;

% Declare beacon positions (should these numbers be stored in another
% file?? % YES THEY SHOULD BE load them with the rest of the data
% sideDist = 1.52; % m, 2x this distance is length of vehicle
% halfwidth = 1.22; %m, 2x this is width of vehicle
% 
% sensorPositions = [
%     -halfwidth, -sideDist;
%     -halfwidth, 0;
%     -halfwidth, sideDist;
%     halfwidth, sideDist;
%     halfwidth, 0;
%     halfwidth, -sideDist];

sensorPositions = zeros(2, NUM_RECEIVERS);

% Plot or no plot?
PLOT = true;
myPlot = [];

% Live or simulated?
LIVE = false;

if (LIVE) 
    %   Specify beacon locations
    
    %   initialize beacons (do all this in beacon-handling class?)

    %   collect garbage

    %   ENSURE ALL OF THEM ARE TALKING TO YOU

    %   They are talking? Good, start up everything else

    %   Create file to log to (inside file handling class!!)

else
    sim_file = 'data/data_outside_10-30-2017_13-57-05-front1_forMat.csv';
    
    data = csvread(sim_file);
    
    %disp(size(sensorPositions(1,:)));
    %disp(size(data(1,2:2+NUM_RECEIVERS)));
    
    sensorPositions(1,:) = data(1,3:2+NUM_RECEIVERS);
    sensorPositions(2,:) = data(2,3:2+NUM_RECEIVERS);
    
    %disp(sensorPositions);
    
    
    
    
    % Create model (includes particle filter, mapping RSSI-m, etc...
    model = Model(sensorPositions);
    
    % Create plot class
    if (PLOT)
        myPlot = PlotClass(max(sensorPositions(1,:)), max(sensorPositions(2,:)), ...
            model.bound, ... 
            LIVE); % Not live if in this branch, leave for ease of reuse
        
        
    end
    
    disp('starting loop');
    
    % Loop over data
    for s=3:length(data)
        [statePred, covPred] = predict(model.pf, model.noise);
        disp('exited predict');
        
        mapped = model.RSSI_TO_M_COEFF * exp(model.RSSI_TO_M_EXP * data(s, 3:2+NUM_RECEIVERS));
        
        %[stateCorrected, covCorrected] = correct(model.pf, data(s, 3:2+NUM_RECEIVERS), sensorPositions);
        [stateCorrected, covCorrected] = correct(model.pf, mapped, sensorPositions);
        disp('exited correct');
        
        disp(stateCorrected);
        
        %NOW JUST COMPARE ESTIMATED TO TRUTH, OUTPUT IT 
        
        %myPlot.updatePlotSim(model.pf, data(s,1), stateCorrected, data(s, 2+NUM_RECEIVERS:3+NUM_RECEIVERS));
        %disp('updated plot');
        
    end
    
    
    
    
    
end









