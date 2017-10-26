classdef Sensors
    
    properties(SetAccess = public)
        
        
        
    end
    
    properties(SetAccess = private)
        
        % The number of sensors
        NUM_SENSORS
        
        % Cell array of sensor addresses 
        addrs
        
        % Cell array of sensor serial ports 
        ports
        
        
        
    end
    
    methods
        
        function obj = Sensors(NUM_SENSORS)
            delete(instrfindall) % For good measure
            
            obj.NUM_SENSORS = NUM_SENSORS;
            
%             1st sensor is back left corner of vehicle
%             Count counterclockwise
            
            %%%%%%%%%%%%%%%%%% INSERT ADDR ORDER HERE %%%%%%%%%%%%%%%%%%
            % Get addr order by running ????
            
%             obj.addrs{1} = '/dev/tty.usbserial-DN00D3MA';
%             obj.addrs{2} = '/dev/tty.usbserial-DN00D2RN';
%             obj.addrs{3} = '/dev/tty.usbserial-DN00CSPC';
%             obj.addrs{4} = '/dev/tty.usbserial-DN00B9FJ';
%             obj.addrs{5} = '/dev/tty.usbserial-DN00D41X';
%             obj.addrs{6} = '/dev/tty.usbserial-DN00CVZK';
            
            obj.addrs{1} = '/dev/tty.usbserial-DN00D3MA';

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            amsg = sprintf('length(obj.addrs) != NUM_RECEIVERS (%d != %d)  ', length(obj.addrs), NUM_SENSORS);
            
            disp(length(obj.addrs));
            
            assert(length(obj.addrs) == NUM_SENSORS, amsg);
            
            disp('Opening receivers')
            
%             for i = 1:NUM_RECEIVERS
%                 ports{i} = serial(addrs{i}, 'BaudRate', 115200);
%                 foepn(ports{i});
%                 set(ports{i}, 'Timeout', 2);
%             end
            
            obj.ports = serial(obj.addrs, 'BaudRate', 115200);
            fopen(obj.ports);
            set(obj.ports, 'Timeout', 2);
            
            trash = cell(NUM_SENSORS, 1);

            for t = 1:5 % Clearing startup glitches
%                 for i = 1:NUM_RECEIVERS
% 
%                     fwrite(ports{i}, 'A');
%                     %trash = fscanf(ports{i}, '%d');
%                     trash{i} = fscanf(ports{i}, '%d');
% 
%                 end

                fwrite(obj.ports, 'A');
                trash = fscanf(obj.ports, '%d');
                
            end

            disp(trash);
            disp(class(trash));
            %disp(class(cell2mat(trash)));
            %disp(cell2mat(trash));

            disp('done with trash, should be good to run')
            
            
        end
        
        function reading = getReading(obj)
            
            fwrite(obj.ports, 'A');
            % Setting reading here is sufficient for return
            reading = fscanf(obj.ports, '%d'); 
            disp(reading);
            
        end
        
        
        
    end
    
    
    
end