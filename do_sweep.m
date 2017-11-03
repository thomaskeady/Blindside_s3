disp('Starting');

f = 'data/data_outside_10-30-2017_13-57-05-front1_forMat.csv';

myParams = Parameters(f);

gsdR = [0.6, 1, 2, 5, 7.5, 10];

wbdR = [1]; % Doesnt do anything right now

psfR = [0.1, 0.3, 0.5, 0.7, 0.9, 1];

npR  = [500, 1000, 3000, 5000, 7500, 10000];

rsmR = ["multinomial", "systematic", "stratified", "residual"];
%rsmR = ["multinomial"];

myParams.beginSweep(gsdR, wbdR, psfR, npR, rsmR);

disp('done!');