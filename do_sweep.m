disp('Starting');

f = 'data/data_outside_10-30-2017_13-48-09-side1_forMat.csv';

myParams = Parameters(f);

gsdR = [0.1, 0.2, 0.3, 0.4, 0.5, 1, 5];

wbdR = [1]; % Doesnt do anything right now

psfR = [0.1, 0.2, 0.5, 1, 2];

npR  = [250, 500, 1000, 5000, 10000];

rsmR = ["multinomial", "systematic", "stratified", "residual"];
%rsmR = ["multinomial"];

myParams.beginSweep(false, gsdR, wbdR, psfR, npR, rsmR);

disp('done!');