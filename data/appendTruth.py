import csv
from os.path import basename

DATA_FILE = "live_11-05-2017_13-36-54_.csv";
TRUTH_FILE = "4m_L_truth.csv";
OUT_FILE = basename(DATA_FILE) + "_forMat.csv";

x_offset = 0; # Specify widths and offsets here
y_offset = 0; # speficy widths and offsets here

with open(DATA_FILE) as datafile:
    dataReader = csv.reader(datafile, delimiter=',')
    dataRows = list(dataReader);

    with open(TRUTH_FILE) as truthfile:
        truthRows = csv.reader(truthfile, delimiter=',')
        with open(OUT_FILE, 'w') as output:
            w = csv.writer(output, delimiter=',')

            #print(dataRows[0]);
            w.writerow(dataRows[0]);
            w.writerow(dataRows[1]);

            rowNum = 0;
            #for trow in truthRows:
