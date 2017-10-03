% THIS FUNCTION PREDICTS WHERE THE PARTICLES WILL BE NEXT STEP
% Since we have no instructions, we should simply diffuse the particles
% Potential improvements:
%   Find "mean" position of all particles and move away from that
%   Add velocity vector to state and move in that direction
%   Add random particles (is this done for us?)


%function predictedParticles = stf1_1(pf, prevParticles, dT, u)
% varargin is left for us to define
function predictedParticles = stf1_1(pf, prevParticles, noise) 
    
    l = length(prevParticles);

    % 2 for x and y
    random_noise = noise*randn(l, 2);
    
%     disp('prevParticles:');
%     disp(size(prevParticles));
%     
%     disp('random_noise:');
%     disp(size(random_noise));
    
    
    predictedParticles = bsxfun(@plus, prevParticles, random_noise);
    %predictedParticles = prevParticles;
    
    
    
end