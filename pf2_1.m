% D is [secs, mins, raw data... raw data, state est 1... state est n]
%function [avgDist, avgAng, stddevDist, stddevAng, D] = doPF(dataFile, aggFname, directory, params)
function [avgDist, avgAng, stddevDist, stddevAng, D] = pf2_1(simFile, gsd, wbd, psf, np, rsm)

    % Generic stuff
    clear all
    close all
    fclose('all');
    delete(instrfindall) % For open serial ports

    % Output file
    outputname = '';

    % Declare # of receivers
    NUM_RECEIVERS = 6;

    % Declare beacon positions (should these numbers be stored in another
    % file?? % YES THEY SHOULD BE load them with the rest of the data
    % sideDist = 1.52; % m, 2x this distance is length of vehicle
    % halfwidth = 1.22; %m, 2x this is width of vehicle
    % 
    % sensorPositions = [
    %     -halfwidth, -sideDist;
    %     -halfwidth, 0;
    %     -halfwidth, sideDist;
    %     halfwidth, sideDist;
    %     halfwidth, 0;
    %     halfwidth, -sideDist];

    sensorPositions = zeros(2, NUM_RECEIVERS);

    % Plot or no plot?
    PLOT = true;
    myPlot = [];

    % Live or simulated?
    LIVE = false;

    if (LIVE) 
        %   Specify beacon locations

        %   initialize beacons (do all this in beacon-handling class?)

        %   collect garbage

        %   ENSURE ALL OF THEM ARE TALKING TO YOU

        %   They are talking? Good, start up everything else

        %   Create file to log to (inside file handling class!!)

    else
        %sim_file = 'data/data_outside_10-30-2017_13-48-09-side1_forMat.csv';
        sim_file = simFile;

        %outputname = 'processed_data/outside_10-30-2017_13-57-05-front1_n01.csv';
        %fid = fopen(outputname, 'a+');

        data = csvread(sim_file);

        %disp(size(sensorPositions(1,:)));
        %disp(size(data(1,2:2+NUM_RECEIVERS)));

        sensorPositions(1,:) = data(1,3:2+NUM_RECEIVERS);
        sensorPositions(2,:) = data(2,3:2+NUM_RECEIVERS);

        %disp(sensorPositions);




        % Create model (includes particle filter, mapping RSSI-m, etc...
        model = Model(sensorPositions, np, psf, sem, rsm, gsd);

        % Create plot class
        if (PLOT)
            %myPlot = PlotClass(max(sensorPositions(1,:)), max(sensorPositions(2,:)), ...
            %    model.bound, ... 
            %    LIVE); % Not live if in this branch, leave for ease of reuse
            myPlot = PlotClass();
            myPlot.begin(max(sensorPositions(1,:)), max(sensorPositions(2,:)), ...
                sensorPositions, model.bound, ... 
                LIVE); % Not live if in this branch, leave for ease of reuse

        end

        disp('starting loop');

        % Loop over data
        for s=3:length(data)
            [statePred, covPred] = predict(model.pf, model.noise);
            %disp('exited predict');

            secs = data(s, 1);
            mins = data(s, 2);
            raws = data(s, 3:2+NUM_RECEIVERS);
            x_truth = data(s, 3+NUM_RECEIVERS);
            y_truth = data(s, 4+NUM_RECEIVERS);

            %mapped = model.RSSI_TO_M_COEFF * exp(model.RSSI_TO_M_EXP * data(s, 3:2+NUM_RECEIVERS));
            mapped = model.RSSI_TO_M_COEFF * exp(model.RSSI_TO_M_EXP * raws);

            %[stateCorrected, covCorrected] = correct(model.pf, data(s, 3:2+NUM_RECEIVERS), sensorPositions);
            [stateCorrected, covCorrected] = correct(model.pf, mapped, sensorPositions);
            %disp('exited correct');

            %disp(stateCorrected);

            %NOW JUST COMPARE ESTIMATED TO TRUTH, OUTPUT IT 
            % Get dist from truth
            %diff = pdist([stateCorrected, data(s, 2+NUM_RECEIVERS:3+NUM_RECEIVERS)], 'euclidean');
            %diff = pdist([stateCorrected, data(s, 3+NUM_RECEIVERS:4+NUM_RECEIVERS)]);
            %diff = sqrt((stateCorrected(1)-data(s, 3+NUM_RECEIVERS))^2 + (stateCorrected(2)-data(s, 4+NUM_RECEIVERS))^2);
            diff = sqrt((stateCorrected(1)-y_truth)^2 + (stateCorrected(2)-y_truth)^2);

            %disp(data(s, 3+NUM_RECEIVERS:4+NUM_RECEIVERS));
            %disp(stateCorrected);

            %angle = atan2(norm(cross(stateCorrected,data(2+NUM_RECEIVERS:3+NUM_RECEIVERS))), dot(stateCorrected,data(2+NUM_RECEIVERS:3+NUM_RECEIVERS)));
            %angle = atan2(data(s, 3+NUM_RECEIVERS)-stateCorrected(1), data(s, 4+NUM_RECEIVERS)-stateCorrected(2));
            angle = atan2(x_truth-stateCorrected(1), y_truth-stateCorrected(2));

            %disp(diff);
            %disp(angle);
            %disp(sprintf('%f, %f', diff, angle));

            rawString = sprintf('%d, ', raws);

            % secs, mins, raw data, x truth, y truth, x meas, y meas, diff, angle
            toPrint = sprintf('%f,%f,%s,%d,%d,%d,%d,%f,%f', secs, mins, rawString, x_truth, y_truth, stateCorrected(1), stateCorrected(2), diff, angle);

            %disp(toPrint);

            %fprintf(fid, '%s', toPrint);
            %fprintf(fid, '\n');

            %myPlot.updatePlotSim(model.pf, data(s,1), stateCorrected, data(s, 2+NUM_RECEIVERS:3+NUM_RECEIVERS));
            myPlot.updatePlotSim(model.pf, data(s,1), mapped, sensorPositions, stateCorrected, [x_truth, y_truth]);
            disp('updated plot');

        end





    end

end








