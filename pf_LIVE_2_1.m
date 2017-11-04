% D is [secs, mins, raw data... raw data, state est 1... state est n]
%function [avgDistMean, avgAngMean, stddevDistMean, stddevAngMean, avgDistMax, avgAngMax, stddevDistMax, stddevAngMax, D] = pf2_1(sensorPositions, makePlot, gsd_, wbd, psf_, np_, rsm_)
function pf_LIVE_2_1(sensorPositions, makePlot, gsd_, wbd, psf_, np_, rsm_)
    
    %clear all 
    %close all
    %fclose('all');
    delete(instrfindall) % For open serial ports

    % Output file % Now returns all that info in D
    %outputname = '';

    % Declare # of receivers
    NUM_RECEIVERS = length(sensorPositions);

    %sensorPositions = zeros(2, NUM_RECEIVERS);
    

    % Plot or no plot?
    PLOT = makePlot;
    myPlot = [];

    %notNeeded =  0; %holds val of max particle later
    
    % Live or simulated?
    LIVE = true;

    if (LIVE)  % Just put this in another file, too complicated (parameter requirements change a lot
        %   Specify beacon locations
        % Sensor positions are included in function call

        %   initialize beacons (do all this in beacon-handling class?)
        %   collect garbage 
        %   ENSURE ALL OF THEM ARE TALKING TO YOU
        mySens = Sensors(NUM_RECEIVERS);
        %   They are talking? Good, start up everything else

        %   Create file to log to (inside file handling class!! - not using one )
        ftimeNow = datestr(now,'mm-dd-yyyy_HH-MM-SS');
        fname = sprintf('data/live_%s_.csv', ftimeNow);
        fid = fopen(fname, 'a+');
        
        cleanupobj = onCleanup(@() cleanmeup(fid));
        
        % 2 column offset for sec and minute columns
        fprintf(fid, ',,%f,%f,%f,%f,%f,%f\n', sensorPositions(:, 1)); % print all x vals
        fprintf(fid, ',,%f,%f,%f,%f,%f,%f\n', sensorPositions(:, 2)); % print all y vals 
        
        % Create model (includes particle filter, mapping RSSI-m, etc...
        model = Model(sensorPositions, gsd_, np_, psf_, rsm_);
        
        % Create plot class
        if (PLOT)
            myPlot = PlotClass();
            
            %disp(max(sensorPositions(:,1)));
            %disp(max(sensorPositions(:,2)));
            
            myPlot.begin(max(sensorPositions(1,:)), max(sensorPositions(2,:)), ...
                sensorPositions, model.bound, ... 
                LIVE); % Not live if in this branch, leave for ease of reuse

        end

        disp('starting loop');
        tic % Start stopwatch 
        while 1 < 2 
        
            % Predict
            [statePred, covPred] = predict(model.pf, model.noise);
            
            % Take reading
            measurement = mySens.getReading();
            disp(measurement);
            
            % Print raw measurements to file
            elapsedTime = toc;
            etimeMins = elapsedTime/60.0;
            fprintf(fid, '%f,%f,%f,%f,%f,%f,%f,%f,', elapsedTime, etimeMins, measurement);
            fprintf(fid, '\n'); % In case above print is not complete, still get newline
            
            % Map measurements to distance
            mapped = model.RSSI_TO_M_COEFF * exp(model.RSSI_TO_M_EXP * measurement);
            
            % Update prediction 
            [stateCorrected, covCorrected] = correct(model.pf, [gsd_, mapped], sensorPositions);
            
            
            disp(stateCorrected);
            

%             if (MODE == 0) % delayTime will be accounted for by plot
%                 pause;
%             else
%                 pause(dt);
%             end
            if (PLOT)
                % Just put truth outside the boundary 
                myPlot.updatePlotLive(model.pf, elapsedTime, mapped, sensorPositions, stateCorrected, covCorrected);
                %disp('updated plot');
            end


        end
        
        
    else



    end

end



% After ctrl-c goes here
function cleanmeup(fid)
    
    disp('deleting instrfindall');
    delete(instrfindall);
    %clear all;

    fclose(fid);

    disp('Done!');

end







