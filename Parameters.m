classdef Parameters
    
    properties(SetAccess = public)
        
        % Stddev of the circular gaussian sweep in MLF
        gaussianStddev
        
        % Constant of (inverse) proportionality between measured dist and
        % weight given by that sensor
        weightByDist
        
        % How much to scatter (not diffuse, try that later) particles in
        % transition function
        particleScatterFactor
        
        % How many particles are in the filter
        numParticles
        
        
        % Things that should be in here somehow but arent just a number:
        %   Throw out large(st) readings
        %   Resampling method
        %   State estimation method (actually do multiple of these each
        %                            round)
        
        
    end
    
    properties(SetAccess = private)
        
        % File handles
        %   One master where information across all runs is aggregated
        %       Avgs, stddevs, etc
           
        % Aggregate file - holds important measures for each run
        aggFname
        
        % Holds folder to more in-depth data 
        directory
        
        % The name of the simulation file with all the data!!
        simFile
        
    end
    
    methods
        
        function obj = Parameters(simFile)
            
            timeNow = datestr(now,'mm-dd-yyyy_HH-MM-SS');
        
            newFolder = sprintf('processed_data/sweep_%s', timeNow);
            mkdir newFolder

            obj.aggFname = sprintf('processed_data/sweep_%s_agg.csv', timeNow);
            obj.directory = newFolder;
            %obj.aggFid = fopen(aggFname, 'a+');
            
            obj.simFile = simFile;
            
        end
        
        function beginSweep(gsdR, wbdR, psfR, npR)
            
            afid = fopen(obj.aggFname, 'a+');
            
            
            tic
            
            for i = 1:numel(gsdR)
                gsd = gsdR(i);
                
                for j = 1:numel(wbdR)
                    wbd = wbdR(j);
                    
                    for k = 1:numel(psfR)
                        psf = psfR(k);
                        
                        for l = 1:numel(npR)
                            np = npR(l);
                            
                            thisFilename = sprintf('%s/gsd%d_wbd%d_psf%d_npR%d.csv', ...
                                obj.directory, makeInt(gsd), makeInt(wbd), makeInt(psf), makeInt(np));
                            tfid = fopen(thisFilename, 'a+');
                            
                            % D is big data matrix
                            [avgDist, avgAng, stddevDist, stddevAng, D] = doPF(simFile, gsd, wbd, psf, np);
                            
                            fprintf(afid, '%d,%d,%d,%d,%d,%d,%d,%d', bsd, wbd, psf, np, ...
                                avgDist, avgAng, stddevDist, stddevAng);
                            fprintf(afid, '\n');
                            
                            
                            
                        end
                    end
                end
            end
            
            fclose(afid);
            
            toc
            
        end
        
        function toReturn = makeInt(notInt)
            while (0 ~= notInt - floor(notInt))
                notInt = notInt * 10;
            end
            toReturn = notInt;
        end
        
    end
    
end