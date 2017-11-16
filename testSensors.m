

NUM_SENSORS = 3;

mySens = Sensors(NUM_SENSORS);

pause;

while 1 < 2
    
    measurement = mySens.getReading();
    pause;
    
end

disp('Done!');
