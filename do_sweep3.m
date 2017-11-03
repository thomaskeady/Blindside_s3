disp('Starting');

f = 'data/data_outside_10-30-2017_14-07-19-front2_forMat.csv';

myParams = Parameters(f);

gsdR = [0.1, 0.2, 0.3, 0.4, 0.5, 0.75, 1, 2, 5, 10];

wbdR = [1]; % Doesnt do anything right now

psfR = [0.1 0.5, 0.7, 0.9, 1, 1.5, 2, 3, 5, 10];

npR  = [250, 500, 1000, 3000, 5000, 7500, 10000];

rsmR = ["multinomial", "systematic", "stratified", "residual"];
%rsmR = ["multinomial"];

myParams.beginSweep(false, gsdR, wbdR, psfR, npR, rsmR);

disp('done!');