classdef Model < handle
% Holds all the tuable parameters of the particle filter
    
    properties(SetAccess = public)
        % The particle filter
        %pf = robotics.ParticleFilter % Is this allowed here?
        pf
        
        % # of particles in the filter
        NUM_PARTICLES = 1000
        
        % Boundaries of the system, square with edge 2*bound
        bound = 10
        
        % sensor positions (x, y)
        sensorPositions
        
        % Noise parameter DONT FORGET TO CHANGE FILENAMES AS CHANGE NOISE
        noise = 0.1
        
        % State estimation method
        sem = 'mean' % or 'maxweight'
        
        % Resampling mehtod 'multinomial' or 'systematic'
        rsm = 'systematic'
        
        % Gaussian stddev in mlf
        gsd
        
        % RSSI to m conversion coeffs
        RSSI_TO_M_COEFF = 0.00482998
        RSSI_TO_M_EXP = -0.104954
        
    end
    
    properties(SetAccess = private)
            
        
    end
    
    methods
        
%         function obj = Model(sensorPositions, gsd, numParticles, psf, rsm)
        %function obj = Model()
%             %pf = robotics.ParticleFilter; % Do stuff like this in the
%             %properties
%             obj.pf = robotics.ParticleFilter;
%             
%             obj.gsd = gsd;
%             obj.NUM_PARTICLES = numParticles;
%             obj.noise = psf;
%             %obj.sem = sem;
%             obj.rsm = rsm;
%             
%             stateBounds = [
%                 -obj.bound, obj.bound;
%                 -obj.bound, obj.bound];
%             initialize(obj.pf, obj.NUM_PARTICLES, stateBounds);
%             
%             obj.pf.StateEstimationMethod = 'mean'; % is this allowed in the properties?
%             obj.pf.ResamplingMethod = obj.rsm; 
%             
%             obj.pf.StateTransitionFcn = @stf1_1;
%             obj.pf.MeasurementLikelihoodFcn = @mlf1_1;
%             
%             obj.sensorPositions = sensorPositions;
            
            % Do nothing?

        %end
        
        %function begin(obj, array)
        %function begin(obj, sensorPosition, gsd, numParticles, psf, rsm)
        function obj = Model(sensorPosition_, gsd_, numParticles_, psf_, rsm_)
        
             %[sensorPosition, gsd, numParticles, psf, rsm] = array;
%             sensorPosition = array(0);
%             gsd = array(1);
%             numParticles = array(2);
%             psf = array(3);
%             rsm = array(4); 
            
            obj.pf = robotics.ParticleFilter;
            
            obj.gsd = gsd_;
            obj.NUM_PARTICLES = numParticles_;
            obj.noise = psf_;
            %obj.sem = sem;
            obj.rsm = rsm_;
            
            stateBounds = [
                -obj.bound, obj.bound;
                -obj.bound, obj.bound];
            initialize(obj.pf, obj.NUM_PARTICLES, stateBounds);
            
            obj.pf.StateEstimationMethod = 'mean'; % is this allowed in the properties?
            obj.pf.ResamplingMethod = obj.rsm; 
            
            obj.pf.StateTransitionFcn = @stf1_1;
            obj.pf.MeasurementLikelihoodFcn = @mlf1_1;
            
            obj.sensorPositions = sensorPosition_;
        end
        
        function [stateCorrected, covCorrected] = correct(pf, measurement, sensorPositions)
            [stateCorrected, covCorrected] = correct(pf, measurement, sensorPositions, obj.gsd);
            
            
        end
        
        function [statePred, covPred] = predict(pf, NOISE)
            [statePred, covPred] = predict(pf, NOISE);
            
        end
        
    end
    
end