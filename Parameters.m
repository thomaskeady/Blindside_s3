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
        
        
        
    end
    
    methods
        
        function obj = Parameters()
            
            timeNow = datestr(now,'mm-dd-yyyy_HH-MM-SS');
        
            newFolder = sprintf('processed_data/sweep_%s', timeNow);
            mkdir newFolder

            obj.aggFname = sprintf('processed_data/sweep_%s_agg.csv', timeNow);
            
            %obj.aggFid = fopen(aggFname, 'a+');
            
            
        end
        
        function beginSweep(gsdR, wbdR, psfR)
            
            tic
            
            for i = 1:numel(gsdR)
                gsd = gsdR[i];
                
                for j = 1:numel(wbdR)
                    wbd = gsdR[j];
                    
                    for k = 1:numel(psfR)
                        psf = gsdR[k];
                        
                        
                    end
                end
            end
            
        end
        
        
    end
    
end