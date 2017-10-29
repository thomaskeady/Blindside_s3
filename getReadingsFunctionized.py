
import sys
import serial

NUM_SENSORS = 1;

ports = list();

addrs = [
    '/dev/tty.usbserial-DN00D2RN'#,
    #'/dev/tty.usbserial-DN00CVZK',
    #'/dev/tty.usbserial-DN00B9FJ'
];

def getReadings():
    for i in range(0,NUM_SENSORS):
        ports.append(serial.Serial(addrs[i], 19200));

    print('Done with opening');

    for l in range(0, 1000):
        for i in range(0, NUM_SENSORS):
            ports[i].write('A');
            print('sent');
            #time.sleep(0.01);
            #reading = ports[i].read(4);
            print('reading');
            reading = ports[i].readline();
            print('done reading');
            #printf("%d gave %d", i, reading);
            print '{0} gave {1}'.format(i, reading);


if __name__ == '__main__':
    #x = float(sys.argv[1])
    sys.stdout.write(str(getReadings()))
