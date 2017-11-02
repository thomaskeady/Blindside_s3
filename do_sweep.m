disp('Starting');

f = 'data/data_outside_10-30-2017_13-57-05-front1_forMat.csv';

myParams = Parameters(f);

gsdR = [10];

wbdR = [1]; % Doesnt do anything right now

psfR = [0.1];

npR  = [500];

rsmR = ['mean'];

myParams.beginSweep(gsdR, wbdR, psfR, npR, rsmR);

disp('done!');