
clear all;
close all;

disp(' Start with the back left plugged in and go counterclockwise');
disp(' If the first sensor isn''t plugged in, plug it in now');

pause;

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
    rdiff = setdiff(filtered, nf);
    
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

disp('\n');

for i = 1:length(filtered) 
    disp(sprintf('obj.addrs{%d} = ''%s'';', i, filtered(i)));
end

disp('\n');

clear all;
close all;
