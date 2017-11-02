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
        
        % Each param is an array of values to sweep over
        function beginSweep(obj, gsdR, wbdR, psfR, npR, rsmR)
            
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
                            
                            for m = 1:numel(rsmR)
                                rsm = rsmR(m);
                            
                                thisFilename = sprintf('%s/gsd%d_wbd%d_psf%d_npR%d_rsm%s.csv', ...
                                    obj.directory, makeInt(gsd), makeInt(wbd), makeInt(psf), makeInt(np), rsm);
                                tfid = fopen(thisFilename, 'w');

                                % D is big data matrix
                                [avgDist, avgAng, stddevDist, stddevAng, avgDistMax, avgAngMax, stddevDistMax, stddevAngMax, D] = pf2_1(obj.simFile, true, gsd, wbd, psf, np, rsm);

                                csvwrite(tfid, D);

                                fprintf(afid, '%d,%d,%d,%d,%s,%d,%d,%d,%d,%d,%d,%d,%d', bsd, wbd, psf, np, rsm, ...
                                    avgDist, avgAng, stddevDist, stddevAng, avgDistMax, avgAngMax, stddevDistMax, stddevAngMax);
                                fprintf(afid, '\n');
                            
                                disp(thisFilename);
                            
                            end
                        end
                    end
                end
            end
            
            fclose(afid);
            
            toc
            
        end
        
%         function toReturn = makeInt(notInt)
%             while (0 ~= notInt - floor(notInt))
%                 notInt = notInt * 10;
%             end
%             toReturn = notInt;
%         end
        
    end
    
end