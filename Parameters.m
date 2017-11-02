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
        aggFid
        
        
        
        
    end
    
    methods
        
        function obj = Parameters()
            
            
        end
        
        function beginSweep(gsdR, wbdR, psfR)
            
            
            
        end
        
        
    end
    
end