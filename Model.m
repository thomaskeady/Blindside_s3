classdef Model
% Holds all the tuable parameters of the particle filter
    
    properties(SetAccess = public)
        % The particle filter
        pf = robotics.ParticleFiler % Is this allowed here?
        
        % # of particles in the filter
        NUM_PARTICLES
        
        % Boundaries of the system, square with edge 2*bound
        bound
        
        
        
    end
    
    properties(SetAccess = private)
            
        
    end
    
    methods
        
        function obj = Model()
            %pf = robotics.ParticleFilter; % Do stuff like this in the
            %properties
            obj.pf.StateEstimationMethod = 'maxweight'; % is this allowed in the properties?
            obj.pf.ResamplingMethod = 'systematic'; 
            
            obj.pf.StateTransitionFcn = @stf1_1;
            obj.pf.MeasurementLikelihoodFcn = @mlf1_1;
            
            
            
        end
        
    end
    
end