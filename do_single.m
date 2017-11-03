disp('Starting');

f = 'data/data_outside_10-30-2017_13-57-05-front1_forMat.csv';

myParams = Parameters(f);

gsdR = [0.6];

wbdR = [1]; % Doesnt do anything right now

psfR = [1];

npR  = [1000];

rsmR = ["multinomial"]; % , "systematic", "stratified", "residual"
%rsmR = ["multinomial"];

myParams.beginSweep(gsdR, true, wbdR, psfR, npR, rsmR);

disp('done!');