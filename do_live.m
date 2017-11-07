disp('Starting');

f = 'data/data_outside_10-30-2017_14-07-19-front2_forMat.csv';

%myParams = Parameters(f); % Don't need Parameters for looping

gsdR = 0.2;

wbdR = 1; % Doesnt do anything right now

psfR = 1;

npR  = 500;

rsmR = "stratified"; % "multinomial", "systematic", "stratified", "residual"


%%%%%%%%%%%%%%%%%% INSERT sensorPositions HERE %%%%%%%%%%%%%%%%%%

%     3         4
%       +-----+
%       |  F  |
%       |     | 
%    2  +     +  5
%       |     | 
%       |     | 
%       +-----+
%     1         6
%


sideDist = 1.52; % m, 2x this distance is length of vehicle
halfwidth = 1.22; %m, 2x this is width of vehicle

sensorPositions = [
    -halfwidth, -sideDist;
    -halfwidth, 0;
    -halfwidth, sideDist;
    halfwidth, sideDist;
    halfwidth, 0;
    halfwidth, -sideDist];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sensorPositions = sensorPositions';


%myParams.beginSweep(gsdR, true, wbdR, psfR, npR, rsmR);
pf_LIVE_2_1(sensorPositions, true, gsdR, wbdR, psfR, npR, rsmR);

disp('done!');




