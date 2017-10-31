
import sys
import serial
import time

#NUM_SENSORS = 1;

ports = list();

# addrs = [
#     '/dev/tty.usbserial-DN00D2RN'#,
#     #'/dev/tty.usbserial-DN00CVZK',
#     #'/dev/tty.usbserial-DN00B9FJ'
# ];
addrs=[
    '/dev/tty.usbserial-DN00B9FJ',
    '/dev/tty.usbserial-DN00CVZK',
    '/dev/tty.usbserial-DN00D2RN'
];

def getReadings():
    for i in range(0,len(addrs)):
        print('oepned');
        ports.append(serial.Serial(addrs[i], 19200, timeout = 2.0));

    print('Done with opening');

    toReturn = list();

    for l in range(0, 1):
        for i in range(0, len(addrs)):
            ports[i].write('A');
            print('sent');
            #time.sleep(0.01);
            #reading = ports[i].read(4);
            print('reading');
            reading = ports[i].readline();
            if (reading == ''):
                print ('Trying again');
                ports[i].write('A');
                time.sleep(0.01);
                reading = ports[i].readline();

            print('done reading');
            toReturn.append(reading);
            #printf("%d gave %d", i, reading);
            print '{0} gave {1}'.format(i, reading);

    return toReturn;


if __name__ == '__main__':
    #x = float(sys.argv[1])
    sys.stdout.write(str(getReadings()))
