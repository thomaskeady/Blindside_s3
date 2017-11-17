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
            % Get addr order by running getOrder.m
            
            obj.addrs{1} = '/dev/tty.usbserial-DN00D41X';
            obj.addrs{2} = '/dev/tty.usbserial-DN00B9FJ';
            obj.addrs{3} = '/dev/tty.usbserial-DN00CVZK';
            obj.addrs{4} = '/dev/tty.usbserial-DN00D2RN';
            obj.addrs{5} = '/dev/tty.usbserial-DN00CZUI';
            obj.addrs{6} = '/dev/tty.usbserial-DN00CSPC';
            obj.addrs{7} = ;
            obj.addrs{8} = ;
            


            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            amsg = sprintf('length(obj.addrs) != NUM_RECEIVERS (%d != %d)  ', length(obj.addrs), NUM_SENSORS);
            
            disp(length(obj.addrs));
            
            assert(length(obj.addrs) == NUM_SENSORS, amsg);
            
            disp('Opening receivers')
            
            for i = 1:NUM_SENSORS
                obj.ports{i} = serial(obj.addrs{i}, 'BaudRate', 9600);
                %obj.ports{i} = serial(obj.addrs{i}, 'BaudRate', 19200);
                fopen(obj.ports{i});
                set(obj.ports{i}, 'Timeout', 2);
            end
            
            trash = cell(NUM_SENSORS, 1);

            for t = 1:5 % Clearing startup glitches
                for i = 1:NUM_SENSORS
                    disp(sprintf('# %d', i));
                    fwrite(obj.ports{i}, 'A');
                    %fwrite(obj.ports{i}, 'A');
                    [trash, count, msg] = fscanf(obj.ports{i}, '%d');
                    %disp(size(msg));
                    if strcmp(msg, 'A timeout occurred before the Terminator was reached.')
                        disp('it was true!!');
                        fwrite(obj.ports{i}, 'A');
                        %fwrite(obj.ports{i}, 'A');
                        [trash, count, msg] = fscanf(obj.ports{i}, '%d');
                    end
                    
                    disp(count);
                    disp(msg);
                end
                
            end

            disp(trash);
            disp(class(trash));
            %disp(class(cell2mat(trash)));
            %disp(cell2mat(trash));

            disp('done with trash, should be good to run')
            
            
        end
        
        function reading = getReading(obj)
            
            reading = zeros(1, obj.NUM_SENSORS);
            
            disp('requested reading');
            for i = 1:obj.NUM_SENSORS
                %disp(i);
                fwrite(obj.ports{i}, 'A');
%                reading(i) = fscanf(obj.ports{i}, '%d'); 
                [buffer, count, msg] = fscanf(obj.ports{i}, '%d'); 
                
                if strcmp(msg, 'A timeout occurred before the Terminator was reached.')
                    %disp('it was true!!');
                    fwrite(obj.ports{i}, 'A');
                    %fwrite(obj.ports{i}, 'A');
                    [buffer, count, msg] = fscanf(obj.ports{i}, '%d');
                end
                    
                disp('disping buffer');
                disp(buffer);
                disp('done disping buffer');
                
                
                reading(i) = buffer;
                %disp(reading);
            end 
                %disp(i);
% 
%             fwrite(obj.ports{2}, 'A');
%             buffer = fscanf(obj.ports{1}, '%d');
%             disp('pre-buffer');
%             disp(buffer);
%             disp('post-buffer');
%             if (buffer)
%                 reading(1) = buffer;
%             end
%             
%             fwrite(obj.ports{3}, 'A');
%             buffer = fscanf(obj.ports{2}, '%d');
%             disp('pre-buffer');
%             disp(buffer);
%             disp('post-buffer');
%             reading(2) = buffer;
%             
%             fwrite(obj.ports{4}, 'A');
%             buffer = fscanf(obj.ports{3}, '%d');
%             disp('pre-buffer');
%             disp(buffer);
%             disp('post-buffer');
%             reading(3) = buffer;
%                 
                
            disp('returning reading');
        end
        
        
        
    end
    
    
    
end