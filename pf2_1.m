% D is [secs, mins, raw data... raw data, state est 1... state est n]
%function [avgDist, avgAng, stddevDist, stddevAng, D] = doPF(dataFile, aggFname, directory, params)
%function [avgDistMean, avgAngMean, stddevDistMean, stddevAngMean, avgDistMax, avgAngMax, stddevDistMax, stddevAngMax, D] = pf2_1(simFile, makePlot, gsd_, wbd, psf_, np_, sem, rsm_)
function [avgDistMean, avgAngMean, stddevDistMean, stddevAngMean, avgDistMax, avgAngMax, stddevDistMax, stddevAngMax, D] = pf2_1(simFile, makePlot, gsd_, wbd, psf_, np_, rsm_)

    %clear all 
    %close all
    %fclose('all');
    delete(instrfindall) % For open serial ports

    % Output file
    outputname = '';

    % Declare # of receivers
    NUM_RECEIVERS = 6;

    sensorPositions = zeros(2, NUM_RECEIVERS);

    % Plot or no plot?
    PLOT = makePlot;
    myPlot = [];

    %notNeeded =  0; %holds val of max particle later
    
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
        sim_file = simFile;

        data = csvread(sim_file);

        %disp(size(sensorPositions(1,:)));
        %disp(size(data(1,2:2+NUM_RECEIVERS)));

        sensorPositions(1,:) = data(1,3:2+NUM_RECEIVERS);
        sensorPositions(2,:) = data(2,3:2+NUM_RECEIVERS);

        %disp(sensorPositions);

        % Create model (includes particle filter, mapping RSSI-m, etc...
        model = Model(sensorPositions, gsd_, np_, psf_, rsm_);

        % Create plot class
        if (PLOT)
            myPlot = PlotClass();
            myPlot.begin(max(sensorPositions(1,:)), max(sensorPositions(2,:)), ...
                sensorPositions, model.bound, ... 
                LIVE); % Not live if in this branch, leave for ease of reuse

        end

        disp('starting loop');

        distMeanList = []; % Can predetermine size for improved speed
        angleMeanList = [];
        distMaxList = [];
        angleMaxList = [];
        D = zeros(length(data), 8);
        %disp(size(D));
        %disp(size(D(1, :)));
        %stateCorrected(1), stateCorrected(2), covCorrected(1,1), covCorrected(1,2), covCorrected(2,1), covCorrected(2,2), model.pf.Particles(idx,1), model.pf.Particles(idx,2)];
        D(1,:) = ["x_mean", "y_mean", "cov11", "cov12", "cov21", "cov22", "x_max", "y_max"];
        
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
            
            %disp(gsd_);
            
            % NOTE HOW EMBEDDING GSF AS PART OF READINGS
            [stateCorrected, covCorrected] = correct(model.pf, [gsd_, mapped], sensorPositions);
            %disp('exited correct');

            %disp(stateCorrected);

            % Get dist from truth
            diff = sqrt((stateCorrected(1)-y_truth)^2 + (stateCorrected(2)-y_truth)^2);

            %disp(data(s, 3+NUM_RECEIVERS:4+NUM_RECEIVERS));
            %disp(stateCorrected);

            angle = atan2(x_truth-stateCorrected(1), y_truth-stateCorrected(2));

            %disp(covCorrected); % Its 2x2
            %disp(size(covCorrected));
            
            [notNeeded, idx] = max(model.pf.Weights);
            diffMax = sqrt((model.pf.Particles(idx,2)-y_truth)^2 + (model.pf.Particles(idx,1)-y_truth)^2);
            angleMax = atan2(x_truth-model.pf.Particles(idx,1), y_truth-model.pf.Particles(idx,2));
            
            distMaxList = [distMaxList, diffMax];
            angleMaxList = [angleMaxList, angleMax];
            
            %D = [D [stateCorrected, covCorrected]];
            %disp(size(D(s)));
            %disp(size([stateCorrected(1), stateCorrected(2), covCorrected(1,1), covCorrected(1,2), covCorrected(2,1), covCorrected(2,2), model.pf.Particles(idx,1), model.pf.Particles(idx,2)]));
            
            D(s,:) = [stateCorrected(1), stateCorrected(2), covCorrected(1,1), covCorrected(1,2), covCorrected(2,1), covCorrected(2,2), model.pf.Particles(idx,1), model.pf.Particles(idx,2)];
            distMeanList = [distMeanList, diff];
            angleMeanList = [angleMeanList, angle];

            
            %disp(diff);
            %disp(angle);
            %disp(sprintf('%f, %f', diff, angle));

            %rawString = sprintf('%d, ', raws);

            % secs, mins, raw data, x truth, y truth, x meas, y meas, diff, angle
            %toPrint = sprintf('%f,%f,%s,%d,%d,%d,%d,%f,%f', secs, mins, rawString, x_truth, y_truth, stateCorrected(1), stateCorrected(2), diff, angle);

            %disp(toPrint);

            %fprintf(fid, '%s', toPrint);
            %fprintf(fid, '\n');

            if (PLOT)
                %myPlot.updatePlotSim(model.pf, data(s,1), stateCorrected, data(s, 2+NUM_RECEIVERS:3+NUM_RECEIVERS));
                myPlot.updatePlotSim(model.pf, data(s,1), mapped, sensorPositions, stateCorrected, [x_truth, y_truth]);
                %disp('updated plot');
            end

        end

        avgDistMean = mean(distMeanList);
        avgAngMean = mean(angleMeanList);
        stddevDistMean = std2(distMeanList); 
        stddevAngMean = std2(angleMeanList);
        avgDistMax = mean(distMaxList);
        avgAngMax = mean(angleMaxList);
        stddevDistMax = std2(distMaxList); 
        stddevAngMax = std2(angleMaxList);


    end

end








