disp('Starting');

f = 'data/data_outside_10-30-2017_14-07-19-front2_forMat.csv';

myParams = Parameters(f);

gsdR = [0.2];

wbdR = [1]; % Doesnt do anything right now

psfR = [0.1];

npR  = [250];

rsmR = ["stratified"]; % "multinomial", "systematic", "stratified", "residual"

myParams.beginSweep(gsdR, true, wbdR, psfR, npR, rsmR);

disp('done!');