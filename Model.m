classdef Model
% Holds all the tuable parameters of the particle filter
    
    properties(SetAccess = public)
        % The particle filter
        %pf = robotics.ParticleFilter % Is this allowed here?
        pf
        
        % # of particles in the filter
        NUM_PARTICLES = 1000
        
        % Boundaries of the system, square with edge 2*bound
        bound = 8
        
        % sensor positions (x, y)
        sensorPositions
        
        % Noise parameter DONT FORGET TO CHANGE FILENAMES AS CHANGE NOISE
        noise = 0.1
        
        % RSSI to m conversion coeffs
        RSSI_TO_M_COEFF = 0.00482998
        RSSI_TO_M_EXP = -0.104954
        
    end
    
    properties(SetAccess = private)
            
        
    end
    
    methods
        
        function obj = Model(sensorPositions)
            %pf = robotics.ParticleFilter; % Do stuff like this in the
            %properties
            obj.pf = robotics.ParticleFilter;
            
            stateBounds = [
                -obj.bound, obj.bound;
                -obj.bound, obj.bound];
            initialize(obj.pf, obj.NUM_PARTICLES, stateBounds);
            
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