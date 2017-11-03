disp('Starting');

f = 'data/data_outside_10-30-2017_13-48-09-side1_forMat.csv';

myParams = Parameters(f);

gsdR = [0.6, 1, 2, 5];

wbdR = [1]; % Doesnt do anything right now

psfR = [0.5, 0.7, 0.9, 1];

npR  = [500, 1000, 3000, 5000, 7500, 10000];

rsmR = ["multinomial", "systematic", "stratified", "residual"];
%rsmR = ["multinomial"];

myParams.beginSweep(false, gsdR, wbdR, psfR, npR, rsmR);

disp('done!');