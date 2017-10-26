
clear all;
close all;

orig = seriallist;

%disp(old);
%disp(class(old));

TF = startsWith(orig, '/dev/tty.usbserial-');

filtered = orig(TF);

assert(length(filtered) == 1);

disp(filtered);

%finallist;

fcount = 2;

stop = 'a';

while (stop ~= 'd')
    
    new = seriallist;
    TF = startsWith(new, '/dev/tty.usbserial-');
    nf = new(TF);
    
    disp(nf);
    disp('filtered');
    disp(filtered);
    disp('done filtered');
    
    diff = setdiff(nf, filtered);

    disp(size(diff));
    disp(diff);

    if (size(diff) == [1, 0]) 
        disp('Are you sure you plugged in another sensor?');
    elseif (size(diff) == [1, 1])
        disp('New sensor found');
        filtered = [filtered, diff(1)];
    else
        disp('Are you sure you only added one sensor?');
    end
    
    
    
    stop = input('s for another sensor, d for done: ', 's');
end

clear all;
close all;
