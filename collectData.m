main();

function main()    
    % Collect data and save it to a file

    NUM_SENSORS = 6;

    % 0 for hand-prompted
    % 1 for sample every dt seconds
    MODE = 0;
    dt = 0.1;

    %location = '
    fname = sprintf('data/data_outside_%s.csv', datestr(now,'mm-dd-yyyy_HH-MM-SS'));
    fid = fopen(fname, 'a+');

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

    while 1 < 2
        
        measurement = mySens.getReading();
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


