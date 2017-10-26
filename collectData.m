main();

function main()    
    % Collect data and save it to a file

    NUM_SENSORS = 2;

    % 0 for hand-prompted
    % 1 for sample every dt seconds
    MODE = 1;
    dt = 0.1;

    %location = '
    fname = sprintf('data/data_outside_%s.csv', datestr(now,'mm-dd-yyyy_HH-MM-SS'));
    fid = fopen(fname, 'a+');
    
    %%%%%%%%%%Temporary!!!!!!!!
    sideDist = 1.52; % m, 2x this distance is length of vehicle
    halfwidth = 1.22; %m, 2x this is width of vehicle

    sensorPositions = [
    -halfwidth, -sideDist;
    -halfwidth, 0;
    -halfwidth, sideDist;
    halfwidth, sideDist;
    halfwidth, 0;
    halfwidth, -sideDist];
    
    

    fprintf(fid, '%f,%f,%f,%f,%f,%f\n', sensorPositions(:, 1)); % print all x vals
    fprintf(fid, '%f,%f,%f,%f,%f,%f\n', sensorPositions(:, 2)); % print all y vals
    
    %%%% TEST TEST TEST apparently this is scalable? 
    %https://stackoverflow.com/questions/6024775/print-a-vector-with-variable-number-of-elements-using-sprintf
    %fprintf(fid, strtrim(sprintf('%f, ' sensorPositions(:, 1)))); % 
    %fprintf(fid, '\n');
    %fprintf(strtrim(sprintf('%f, ' sensorPositions(:, 2))));
    %fprintf(fid, fid, '\n');
    
    mySens = Sensors(NUM_SENSORS);

    pause;

    % Will catch any ctrl-c inside the loop
    cleanupobj = onCleanup(@() cleanmeup(fid));

    tic
    
    while 1 < 2
        
        measurement = mySens.getReading();
        toc
        disp(measurement);
        fprintf(fid, '%f,%f,%f,%f,%f,%f,', measurement);
        fprintf(fid, '\n'); % In case above print is not complete, still get newline
        
        if (MODE == 0) 
            pause;
        else
            pause(dt);
        end

    end

end

% After ctrl-c goes here
function cleanmeup(fid)
    
    delete(instrfindall);
    %clear all;

    fclose(fid);

    disp('Done!');

end


