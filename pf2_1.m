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



