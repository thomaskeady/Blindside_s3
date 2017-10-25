classdef Sensors
    
    properties(SetAccess = public)
        
        
        
    end
    
    properties(SetAccess = private)
        
        % Cell array of sensor addresses 
        addrs
        
        % Cell array of sensor serial ports 
        ports
        
        
        
    end
    
    methods
        
        function obj = Sensors(NUM_RECEIVERS)
            delete(instrfindall) % For good measure
            
            disp('Opening receivers')
            
            
            
        end
        
        
        
        
        
    end
    
    
    
end