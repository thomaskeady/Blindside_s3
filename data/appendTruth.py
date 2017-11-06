import csv
from os.path import splitext

DATA_FILE = "live_11-05-2017_13-24-42_3mL.csv";
TRUTH_FILE = "3m_L_truth.csv";
OUT_FILE = splitext(DATA_FILE)[0] + "_forMat.csv";

numSensors = 6; # Therefore offset for truth rows is this + 2
x_offset = -(1.22 + 3); # Specify widths and offsets here
y_offset = -3.81; # speficy widths and offsets here
moving_dir = 'y'; # 'x' or 'y'

with open(DATA_FILE, "U") as datafile:
    dataReader = csv.reader(datafile, delimiter=',')
    dataRows = list(dataReader);

    with open(TRUTH_FILE, "U") as truthfile:
        truthRows = csv.reader(truthfile, delimiter=',')
        with open(OUT_FILE, 'w') as output:
            w = csv.writer(output, delimiter=',')

            #print(dataRows[0]);
            w.writerow(dataRows[0]);
            w.writerow(dataRows[1]);

            r = 2; # 3rd row is where data starts
            currSecs = 0;
            first = True;
            for trow in truthRows:
                if first:
                    first = False;
                else:
                    #print (trow[0]);
                    # 0 = dist, 1 = pos, 2 = mins 3 = seconds
                    seconds = float(trow[2])*60 + float(trow[3]);
                    print (seconds)

                    while float(dataRows[r][0]) < seconds:
                        # Start putting truth here
                        print(r);
                        y_pos = float(trow[1]) + y_offset;

                        if moving_dir == 'y':
                            #dataRows[r].append(x_offset);
                            dataRows[r][numSensors+2] = x_offset;
                            dataRows[r].append(y_pos);
                            #dataRows[r][numSensors+3] = y_pos;

                        w.writerow(dataRows[r])

                        r += 1;
