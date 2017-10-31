
disp('starting');

%syscommand = ['python getReadingsFunctionized.py'];

[s,r ] = system('python getReadingsFunctionized.py');

disp('after call');

disp(r);
disp('-------------');
disp(s);

disp('done!');


