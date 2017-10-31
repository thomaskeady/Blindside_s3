classdef Model
% Holds all the tuable parameters of the particle filter
    
    properties(SetAccess = public)
        % The particle filter
        pf = robotics.ParticleFiler % Is this allowed here?
        
        % # of particles in the filter
        NUM_PARTICLES
        
        % Boundaries of the system, square with edge 2*bound
        bound
        
        % sensor positions (x, y)
        sensorPositions
        
        % Noise parameter
        noise = 3
        
    end
    
    properties(SetAccess = private)
            
        
    end
    
    methods
        
        function obj = Model(sensorPositions)
            %pf = robotics.ParticleFilter; % Do stuff like this in the
            %properties
            obj.pf.StateEstimationMethod = 'maxweight'; % is this allowed in the properties?
            obj.pf.ResamplingMethod = 'systematic'; 
            
            obj.pf.StateTransitionFcn = @stf1_1;
            obj.pf.MeasurementLikelihoodFcn = @mlf1_1;
            
            obj.sensorPositions = sensorPositions;
            
        end
        
        function [stateCorrected, covCorrected] = correct(pf, measurement, sensorPositions)
            [stateCorrected, covCorrected] = correct(pf, measurement, sensorPositions);
            
            
        end
        
        function [statePred, covPred] = predict(pf, NOISE)
            [statePred, covPred] = predict(pf, NOISE);
            
        end
        
    end
    
end