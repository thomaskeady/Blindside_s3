disp('Starting');

f = 'data/data_outside_10-30-2017_13-57-05-front1_forMat.csv';

myParams = Parameters(f);

gsdR = [5, 10];

wbdR = [1, 2]; % Doesnt do anything right now

psfR = [0.1, 1];

npR  = [500, 1000];

rsmR = ["multinomial", "systematic", "stratified", "residual"];
%rsmR = ["multinomial"];

myParams.beginSweep(gsdR, wbdR, psfR, npR, rsmR);

disp('done!');