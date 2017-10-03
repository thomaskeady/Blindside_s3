

% Measurement should be raw vals from 6 sensors, all the math done here
%
function likelihood = mlf1_1(pf, predictParticles, measurement, sensorPositions)
    
    % First map measurements to most-likely radius from each sensor
    % Get from Andrew
    
%     disp('measurement:');
%     disp(size(measurement));
    
    % For now, measurements are in meters. In future, convert from RSSI to
    % meters
    dist = measurement.*1;
    
    %disp(measurement);
    
    % Then make distribution around each sensor (relative to origin!)
    %mean = radius from above
    stddev = 1; % meter
    scale = 1;  % scaling factor
    
    numParticles = length(predictParticles);
    numSensors = length(measurement);
    
    % Weight given to each particle by each sensor
    %sensor = double.empty(numSensors, numParticles);
    sensor = zeros(numSensors, numParticles);
    
%     disp('sensor');
%     disp(size(sensor));
%     
%     disp('predictParticles');
%     disp(size(predictParticles));
    
    predictParticles = predictParticles';
    
    % One line per sensor
    sensor(1, :) = (1/sqrt(2*pi*stddev^2)) * exp( ...
        ((predictParticles(1, :) - sensorPositions(1, 1)).^2 + ...
         (predictParticles(2, :) - sensorPositions(1, 2)).^2 + ...
         dist(1)^2) ... 
        /(-2*stddev^2));
    
%    disp(sensor(1, :));% all zeros!!!
%    disp((1/sqrt(2*pi*stddev^2))); % nonzero
%     disp((predictParticles(1, :) + sensorPositions(1, 1)).^2);% nonzero
%     disp((predictParticles(2, :) + sensorPositions(1, 2)).^2);% nonzero
%     disp(dist(1)^2);% nonzero
%     disp((2*stddev^2));% nonzero
%     disp(exp( ...
%          ((predictParticles(1, :) - sensorPositions(1, 1)).^2 + ...
%           (predictParticles(2, :) - sensorPositions(1, 2)).^2 + ...
%           dist(1)^2) ... 
%          /(-2*stddev^2)));


    sensor(2, :) = (1/sqrt(2*pi*stddev^2)) * exp( ...
        ((predictParticles(1, :) - sensorPositions(2, 1)).^2 + ...
         (predictParticles(2, :) - sensorPositions(2, 2)).^2 + ...
         dist(2)^2) ... 
        /(-2*stddev^2));
    
    sensor(3, :) = (1/sqrt(2*pi*stddev^2)) * exp( ...
        ((predictParticles(1, :) - sensorPositions(3, 1)).^2 + ...
         (predictParticles(2, :) - sensorPositions(3, 2)).^2 + ...
         dist(3)^2) ... 
        /(-2*stddev^2));
    
    sensor(4, :) = (1/sqrt(2*pi*stddev^2)) * exp( ...
        ((predictParticles(1, :) - sensorPositions(4, 1)).^2 + ...
         (predictParticles(2, :) - sensorPositions(4, 2)).^2 + ...
         dist(4)^2) ... 
        /(-2*stddev^2));
    
    sensor(5, :) = (1/sqrt(2*pi*stddev^2)) * exp( ...
        ((predictParticles(1, :) - sensorPositions(5, 1)).^2 + ...
         (predictParticles(2, :) - sensorPositions(5, 2)).^2 + ...
         dist(5)^2) ... 
        /(-2*stddev^2));
    
    sensor(6, :) = (1/sqrt(2*pi*stddev^2)) * exp( ...
        ((predictParticles(1, :) - sensorPositions(6, 1)).^2 + ...
         (predictParticles(2, :) - sensorPositions(6, 2)).^2 + ...
         dist(6)^2) ... 
        /(-2*stddev^2));
    
    
    predictParticles = predictParticles'; % Does this get modified/used/returned anywhere?
    
    
    %disp(sensor);
    
    % Sum all distributions on top of each other
    summed = scale*sum(sensor, 1);
    
    %disp(summed);
    
    % Normalize
    measurementNoise = eye(2);
    %likelihood = 1/sqrt((2*pi).^3 * det(measurementNoise)) * exp(-0.5 * summed);
    likelihood = 1/sqrt((2*pi) * det(measurementNoise)) * exp(-0.5 * summed);
    
    disp(likelihood);
    % Return summation
    
end
