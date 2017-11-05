import csv
from os.path import basename

DATA_FILE = "live_11-05-2017_13-36-54_.csv";
TRUTH_FILE = "4m_L_truth.csv";
OUT_FILE = basename(DATA_FILE) + "_forMat.csv";

numSensors = 6; # Therefore offset for truth rows is this + 2
x_offset = 0; # Specify widths and offsets here
y_offset = -12.5; # speficy widths and offsets here
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
            for trow in truthRows:
                #print (trow[0]);
                # 0 = dist, 1 = pos, 2 = mins 3 = seconds
                seconds = trow[2]*60 + trow[3];

                while dataRows[r][0] < seconds:
                    # Start putting truth here
