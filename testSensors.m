

NUM_SENSORS = 1;

mySens = Sensors(NUM_SENSORS);

pause;

while 1 < 2
    
    measurement = mySens.getReading();
    pause;
    
end

disp('Done!');
