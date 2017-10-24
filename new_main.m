% Declare # of beacons

% Declare beacon positions

% Is this with live data or simulated?

% if live:

%   initialize beacons (do all this in beacon-handling class?)

%   collect garbage

%   ENSURE ALL OF THEM ARE TALKING TO YOU

%   They are talking? Good, start up everything else

%   Create file to log to (inside file handling class!!)

% else (simulation)

%   Open sim file 

%   

% Initialize plot (definitely as its own class)

% Initialize model parameters (from file!!)

% Initialize particle filter

% Begin loop

%   get readings (from file or sensors)

%       Log if live from sensors

%   Do filter like we already do

%   Repeat








