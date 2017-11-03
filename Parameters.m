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
            [stat, msg, msgID] = mkdir(newFolder);

            disp(stat);
            disp(msg);
            disp(msgID);
            
            obj.aggFname = sprintf('processed_data/sweep_%s_agg.csv', timeNow);
            obj.directory = newFolder;
            %obj.aggFid = fopen(aggFname, 'a+');
            
            obj.simFile = simFile;
            
        end
        
        % Each param is an array of values to sweep over
        function beginSweep(obj, gsdR, wbdR, psfR, npR, rsmR)
            
            afid = fopen(obj.aggFname, 'a+');
            
            fprintf(afid, "Gaussian stddev, weight by dist, Particle scatter factor, numParticles, resampling method, avgDist, avgAng, stddevDist, stddevAng, avgDistMax, avgAngMax, stddevDistMax, stddevAngMax");
            fprintf(afid, '\n');
            
            tic
            
            for i = 1:numel(gsdR)
                gsd = gsdR(i);
                
%                 disp('gsd: ');
%                 disp(gsd);
                
                for j = 1:numel(wbdR)
                    wbd = wbdR(j);
                    
%                     disp('wbd: ');
%                     disp(wbd);
                    
                    for k = 1:numel(psfR)
                        psf = psfR(k);
                        
%                         disp('psf: ');
%                         disp(psf);
                        
                        for l = 1:numel(npR)
                            np = npR(l);
                            
%                             disp('np: ');
%                             disp(np);
                            
                            for m = 1:numel(rsmR)
                                rsm = rsmR(m);
                            
%                                 disp(rsmR);
%                                 disp('rsm: ');
%                                 disp(rsm);
                                
                                thisFilename = sprintf('%s/gsd%d_wbd%d_psf%d_npR%d_rsm%s.csv', ...
                                    obj.directory, makeInt(gsd), makeInt(wbd), makeInt(psf), makeInt(np), rsm);
                                
                                disp(thisFilename);
                                
                                %tfid = fopen(thisFilename, 'w');
                                
                                % D is big data matrix
                                [avgDist, avgAng, stddevDist, stddevAng, avgDistMax, avgAngMax, stddevDistMax, stddevAngMax, D] = pf2_1(obj.simFile, false, gsd, wbd, psf, np, rsm);

                                %csvwrite(tfid, D);
                                %csvwrite(thisFilename, D);
                                xlswrite(thisFilename, D); % shoudl work on Andrew's computer

%                                 fprintf(afid, '%d,%d,%d,%d,%s,%d,%d,%d,%d,%d,%d,%d,%d', gsd, wbd, psf, np, rsm, ...
%                                     avgDist, avgAng, stddevDist, stddevAng, avgDistMax, avgAngMax, stddevDistMax, stddevAngMax);
                                    fprintf(afid, '%d,%d,%d,%d,%s,%d,%d,%d,%d,%d,%d,%d,%d', gsd, wbd, psf, np, rsm, ...
                                        avgDist, stddevDist, avgAng, stddevAng, avgDistMax, stddevDistMax, avgAngMax, stddevAngMax);
                                    fprintf(afid, '\n');
                            
                                %fclose(tfid);
                            
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