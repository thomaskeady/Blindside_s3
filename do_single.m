disp('Starting');

f = 'data/live_11-05-2017_13-24-42_3mL_forMat.csv';

myParams = Parameters(f);

gsdR = [0.2];

wbdR = [1]; % Doesnt do anything right now

psfR = [0.1];

npR  = [250];

rsmR = ["residual"]; % "multinomial", "systematic", "stratified", "residual"

myParams.beginSweep(gsdR, true, wbdR, psfR, npR, rsmR);

disp('done!');