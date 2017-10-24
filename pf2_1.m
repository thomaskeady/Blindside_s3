% Generic stuff
clear all
close all
fclose('all');
delete(instrfindall) % For open serial ports

% Declare # of receivers
NUM_RECEIVERS = 6;

% Declare beacon positions (should these numbers be stored in another
% file??
sideDist = 1.52; % m, 2x this distance is length of vehicle
halfwidth = 1.22; %m, 2x this is width of vehicle

sensorPositions = [
    -halfwidth, -sideDist;
    -halfwidth, 0;
    -halfwidth, sideDist;
    halfwidth, sideDist;
    halfwidth, 0;
    halfwidth, -sideDist];


% Live or simulated?
LIVE = false;

if (LIVE) 
    %   initialize beacons (do all this in beacon-handling class?)

    %   collect garbage

    %   ENSURE ALL OF THEM ARE TALKING TO YOU

    %   They are talking? Good, start up everything else

    %   Create file to log to (inside file handling class!!)

else
    sim_file = 'linear5m_missingSensors.csv';
    
    data = csvread(sim_file);
    
    
    
    
end









