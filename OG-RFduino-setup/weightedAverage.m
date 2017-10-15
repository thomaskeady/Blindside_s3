clear all
fclose('all');
delete(instrfindall)

x = [-1000 1000 1000 -1000];
y = [-800 -800 800 800];
patch(x, y, [0.9 0.9 0.9]); % light gray

HVL = 150;   % Half vehicle length
HVW = 50;   % Half vehicle width

% Do not necessarily have to be relative to HVW
ID = 2*HVW; % Inner range distance
MD = 3*HVW; % Medium range distance
FD = 5*HVW; % Far range distance


GAP = 20;

MDO = ID + 2*GAP;   % Middle distance offset from vehicle
FDO = ID + MD + 3*GAP;  % Far distance offset from vehicle

vx = [-HVL HVL HVL -HVL];
vy = [-HVW -HVW HVW HVW];
patch(vx, vy, [0 0 0]); % black vehicle

fix = [HVL+GAP HVL+GAP+ID HVL+GAP+ID HVL+GAP];
fiy = [-HVW -HVW HVW HVW];
patch(fix, fiy, [0.8 0.8 0.8])

fmx = [HVL+MDO HVL+MDO+MD HVL+MDO+MD HVL+MDO]
fmy = [-HVW -HVW HVW HVW];
patch(fmx, fmy, [0.8 0.8 0.8])

%%% Front far
ffx = [HVL+FDO HVL+FDO+FD HVL+FDO+FD HVL+FDO];
ffy = [HVW HVW -HVW -HVW];
patch(ffx, ffy, [0.8 0.8 0.8]);

frix = [HVL+GAP HVL+GAP+ID HVL+GAP+ID HVL+GAP];
friy = [-HVW-GAP -HVW-GAP -HVW-GAP-ID -HVW-GAP-ID];
patch(frix, friy,[0.8 0.8 0.8])

frmx = [HVL+MDO HVL+MDO+MD HVL+MDO+MD HVL+GAP HVL+GAP HVL+MDO];
frmy = [-HVW-GAP -HVW-GAP -HVW-MDO-MD -HVW-MDO-MD -HVW-MDO -HVW-MDO];
patch(frmx, frmy, [0.8 0.8 0.8])
 
%%% Front right far
frfx = [HVL+FDO HVL+FDO+FD HVL+FDO+FD HVL+GAP HVL+GAP HVL+FDO];
frfy = [-HVW-GAP -HVW-GAP -HVW-FDO-FD -HVW-FDO-FD -HVW-FDO -HVW-FDO];
patch(frfx, frfy, [0.8 0.8 0.8])

rix = [-HVL HVL HVL -HVL];
riy = [-HVW-GAP -HVW-GAP -HVW-GAP-ID -HVW-GAP-ID];
patch(rix, riy, [0.8 0.8 0.8])

rmx = [-HVL HVL HVL -HVL];
rmy = [-HVW-MDO -HVW-MDO -HVW-MDO-MD -HVW-MDO-MD];
patch(rmx, rmy, [0.8 0.8 0.8])

rfx = [-HVL HVL HVL -HVL];
rfy = [-HVW-FDO -HVW-FDO -HVW-FDO-FD -HVW-FDO-FD];
patch(rfx, rfy, [0.8 0.8 0.8])

%%% Right far
rfx = [-HVL HVL HVL -HVL]
rfy = [-HVW-FDO -HVW-FDO -HVW-FDO-FD -HVW-FDO-FD];
patch(rfx, rfy, [0.8 0.8 0.8])

brix = [-HVL-GAP-ID -HVL-GAP -HVL-GAP -HVL-GAP-ID];
briy = [-HVW-GAP -HVW-GAP -HVW-GAP-ID -HVW-GAP-ID];
patch(brix, briy, [0.8 0.8 0.8])

brmx = [-HVL-MDO-MD -HVL-MDO -HVL-MDO -HVL-GAP -HVL-GAP -HVL-MDO-MD];
brmy = [-HVW-GAP -HVW-GAP -HVW-MDO -HVW-MDO -HVW-MDO-MD -HVW-MDO-MD];
patch(brmx, brmy, [0.8 0.8 0.8])

brfx = [-HVL-FDO-FD -HVL-FDO -HVL-FDO -HVL-GAP -HVL-GAP -HVL-FDO-FD];
brfy = [-HVW-GAP -HVW-GAP -HVW-FDO -HVW-FDO -HVW-FDO-FD -HVW-FDO-FD];
patch(brfx, brfy, [0.8 0.8 0.8])

bix = [-HVL-GAP-ID -HVL-GAP -HVL-GAP -HVL-GAP-ID];
biy = [HVW HVW -HVW -HVW];
patch(bix, biy, [0.8 0.8 0.8])

bmx = [-HVL-MDO-MD -HVL-MDO -HVL-MDO -HVL-MDO-MD];
bmy = [HVW HVW -HVW -HVW];
patch(bmx, bmy, [0.8 0.8 0.8])

bfx = [-HVL-FDO-FD -HVL-FDO -HVL-FDO -HVL-FDO-FD];
bfy = [HVW HVW -HVW -HVW];
patch(bfx, bfy, [0.8 0.8 0.8])

blix = [-HVL-GAP-ID -HVL-GAP -HVL-GAP -HVL-GAP-ID];
bliy = [HVW+GAP+ID HVW+GAP+ID HVW+GAP HVW+GAP];
patch(blix, bliy, [0.8 0.8 0.8])
 
blmx = [-HVL-MDO-MD -HVL-GAP -HVL-GAP -HVL-MDO -HVL-MDO -HVL-MDO-MD];
blmy = [HVW+MDO+MD HVW+MDO+MD HVW+MDO HVW+MDO HVW+GAP HVW+GAP];
patch(blmx, blmy, [0.8 0.8 0.8])

blfx = [-HVL-FDO-FD -HVL-GAP -HVL-GAP -HVL-FDO -HVL-FDO -HVL-FDO-FD];
blfy = [HVW+FDO+FD HVW+FDO+FD HVW+FDO HVW+FDO HVW+GAP HVW+GAP];
patch(blfx, blfy, [0.8 0.8 0.8])

lix = [-HVL HVL HVL -HVL];
liy = [HVW+GAP+ID HVW+GAP+ID HVW+GAP HVW+GAP];
patch(lix, liy, [0.8 0.8 0.8])

lmx = [-HVL HVL HVL -HVL];
lmy = [HVW+MDO+MD HVW+MDO+MD HVW+MDO HVW+MDO];
patch(lmx, lmy, [0.8 0.8 0.8])

lfx = [-HVL HVL HVL -HVL];
lfy = [HVW+FDO+FD HVW+FDO+FD HVW+FDO HVW+FDO];
patch(lfx, lfy, [0.8 0.8 0.8])

flix = [HVL+GAP HVL+GAP+ID HVL+GAP+ID HVL+GAP];
fliy = [HVW+GAP+ID HVW+GAP+ID HVW+GAP HVW+GAP];
patch(flix, fliy, [0.8 0.8 0.8])

flmx = [HVL+GAP HVL+MDO+MD HVL+MDO+MD HVL+MDO HVL+MDO HVL+GAP];
flmy = [HVW+MDO+MD HVW+MDO+MD HVW+GAP HVW+GAP HVW+MDO HVW+MDO];
patch(flmx, flmy, [0.8 0.8 0.8])

%%% Front left far
flfx = [HVL+GAP HVL+FDO+FD HVL+FDO+FD HVL+FDO HVL+FDO HVL+GAP];
flfy = [HVW+FDO+FD HVW+FDO+FD HVW+GAP HVW+GAP HVW+FDO HVW+FDO];
patch(flfx, flfy, [0.8 0.8 0.8])
disp('rendered')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% End generate gui

pause(1);

%              L
%              2
%     3 +------+------+ 1
%       |             |
%     4 +       front + 8
%       |             |
%     5 +------+------+ 7
%              6        
%              R


NUM_RECEIVERS = 8; % Dont forget extra dummy one
START_RECEIVER = 2; % The first one that will get a successful read

disp('Opening receivers')

duinos = cell(NUM_RECEIVERS,1);
duinos{1} = '/dev/tty.usbserial-DN00D2RN';
duinos{2} = '/dev/tty.usbserial-DN00D3MA';
duinos{3} = '/dev/tty.usbserial-DN00CVZK';
duinos{4} = '/dev/tty.usbserial-DN00CZUI';
duinos{5} = '/dev/tty.usbserial-DN00D41X';
duinos{6} = '/dev/tty.usbserial-DN00D2T3';
duinos{7} = '/dev/tty.usbserial-DN00CTR3';
duinos{8} = '/dev/tty.usbserial-DN00CU74';
%duinos{9} = '/dev/tty.usbserial-DN00B9FJ';
%duinos{10} = 


ports = cell(NUM_RECEIVERS, 1);

ports{1} = serial(duinos{1}, 'BaudRate', 115200);
fopen(ports{1});
%set(ports{1}, 'Timeout', 0.1);
set(ports{1}, 'Timeout', 2);

% 
%for i = 1:length(duinos)
for i = START_RECEIVER:NUM_RECEIVERS
    %disp(duinos{i});
    %disp('next');
    ports{i} = serial(duinos{i},'BaudRate',115200);
    fopen(ports{i});
    set(ports{i}, 'Timeout', 2);
    
end

%disp(ports);

pause(3);

oFR = -2;
oFL = -2;
oBR = -2;
oBL = -2;

avgFR = -3;
avgFL = -3;
avgBR = -3;
avgBL = -3;

xold = [0 0 0 0];
yold = [0 0 0 0];

xxold = [0 0 0 0];
xyold = [0 0 0 0];

readings = cell(NUM_RECEIVERS, 1);

trash = 0;

for t = 1:5 % Clearing startup glitches
    for i = 1:NUM_RECEIVERS
        
        fwrite(ports{i}, 'A');
        trash = fscanf(ports{i}, '%d');
        
    end
end

disp('done with trash')

check = 1;

while check > 0
    
    disp('before reads')
    
    for i = 1:NUM_RECEIVERS
        
        fwrite(ports{i}, 'A');
        readings{i} = fscanf(ports{i}, '%d');
        %disp(i);
        %disp(oFL);
        
    end
%         
    
    
    %window_size = 10
    %mvingeFR = tsmovavg(FRarray, 'e', window_size, 1);
    %mvingeFL = tsmovavg(FLarray, 'e', window_size, 1);
    %mvingeBR = tsmovavg(BRarray, 'e', window_size, 1);
    %mvingeBL = tsmovavg(BLarray, 'e', window_size, 1);
    
    %plot(mvingeFR, mvingeFL)
    
    space_average = cell(NUM_RECEIVERS, 1); % -1 for not using dummy
    
    minAvg = -100;  % Calling them min/max in terms of magnitude!!!
    minLoc = 0;
    
    maxAvg = 0;
    maxLoc = 0;
    
    for n = 1:(NUM_RECEIVERS - 2)
        space_average{n} = ((readings{n}/2) + readings{n + 1} + (readings{n + 2}/2))/3;
        if (space_average{n} > minAvg) 
            minLoc = n;
            minAvg = space_average{n};
        elseif (space_average{n} < maxAvg) 
            maxLoc = n;
            maxAvg = space_average{n};
        end
    end
    
    space_average{NUM_RECEIVERS - 1} = ((readings{NUM_RECEIVERS - 1}/2) + readings{NUM_RECEIVERS} + (readings{1}/2))/3;
    if (space_average{NUM_RECEIVERS - 1} > minAvg)
        minLoc = NUM_RECEIVERS - 1;
        minAvg = space_average{NUM_RECEIVERS - 1};
    elseif (space_average{n} < maxAvg)
        maxLoc = n;
        maxAvg = space_average{n};
    end
    
    space_average{NUM_RECEIVERS} = ((readings{NUM_RECEIVERS}/2) + readings{1} + (readings{2}/2))/3;
    if (space_average{NUM_RECEIVERS} > minAvg)
        minLoc = NUM_RECEIVERS;
        minAvg = space_average{NUM_RECEIVERS};
    elseif (space_average{n} < maxAvg)
        maxLoc = n;
        maxAvg = space_average{n};
    end
    
    
    
    disp(readings);
    disp(space_average);
    disp(minLoc);
    disp(maxLoc);
    
    THRESH_I = -35;
    THRESH_M = -45;
    
    patch(xold, yold, [0.8 0.8 0.8]);
    patch(xxold, xyold, [0.8 0.8 0.8]);
    
    xold = [0 0 0 0];
    yold = [0 0 0 0];
    
    xxold = [0 0 0 0];
    xyold = [0 0 0 0];
    
    disp('switching');
%    disp(min);
    
    if (minAvg > THRESH_I)
        switch minLoc
            case 8  % FL
                patch(flix, fliy, 'red');
                xold = flix;
                yold = fliy;
            case 1  % L
                patch(lix, liy, 'red');
                xold = lix;
                yold = liy;
            case 2  % BL
                patch(blix, bliy, 'red');
                xold = blix;
                yold = bliy;
            case 3  % B
                patch(bix, biy, 'red');
                xold = bix;
                yold = biy;
            case 4  % BR
                patch(brix, briy, 'red');
                xold = brix;
                yold = briy;
            case 5  % R
                patch(rix, riy, 'red');
                xold = rix;
                yold = riy;
            case 6  % FR
                patch(frix, friy, 'red');
                xold = frix;
                yold = friy;
            case 7  % F
                patch(fix, fiy, 'red');
                xold = fix;
                yold = fiy;
        end %switch
    elseif (minAvg > THRESH_M)
        switch minLoc
            case 8  % FL
                patch(flmx, flmy, 'red');
                xold = flmx;
                yold = flmy;
            case 1  % L
                patch(lmx, lmy, 'red');
                xold = lmx;
                yold = lmy;
            case 2  % BL
                patch(blmx, blmy, 'red');
                xold = blmx;
                yold = blmy;
            case 3  % B
                patch(bmx, bmy, 'red');
                xold = bmx;
                yold = bmy;
            case 4  % BR
                patch(brmx, brmy, 'red');
                xold = brmx;
                yold = brmy;
            case 5  % R
                patch(rmx, rmy, 'red');
                xold = rmx;
                yold = rmy;
            case 6  % FR
                patch(frmx, frmy, 'red');
                xold = frmx;
                yold = frmy;
            case 7  % F
                patch(fmx, fmy, 'red');
                xold = fmx;
                yold = fmy;
        end %switch

    else
        switch minLoc
             case 8  % FL
                patch(flfx, flfy, 'red');
                xold = flfx;
                yold = flfy;
            case 1  % L
                patch(lfx, lfy, 'red');
                xold = lfx;
                yold = lfy;
            case 2  % BL
                patch(blfx, blfy, 'red');
                xold = blfx;
                yold = blfy;
            case 3  % B
                patch(bfx, bfy, 'red');
                xold = bfx;
                yold = bfy;
            case 4  % BR
                patch(brfx, brfy, 'red');
                xold = brfx;
                yold = brfy;
            case 5  % R
                patch(rfx, rfy, 'red');
                xold = rfx;
                yold = rfy;
            case 6  % FR
                patch(frfx, frfy, 'red');
                xold = frfx;
                yold = frfy;
            case 7  % F
                patch(ffx, ffy, 'red');
                xold = ffx;
                yold = ffy;
        end %switch

    end
    
   
    switch maxLoc
        case 8  % FL
            patch(flfx, flfy, 'blue');
            xxold = flfx;
            xyold = flfy;
        case 1  % L
            patch(lfx, lfy, 'blue');
            xxold = lfx;
            xyold = lfy;
        case 2  % BL
            patch(blfx, blfy, 'blue');
            xxold = blfx;
            xyold = blfy;
        case 3  % B
            patch(bfx, bfy, 'blue');
            xxold = bfx;
            xyold = bfy;
        case 4  % BR
            patch(brfx, brfy, 'blue');
            xxold = brfx;
            xyold = brfy;
        case 5  % R
            patch(rfx, rfy, 'blue');
            xxold = rfx;
            xyold = rfy;
        case 6  % FR
            patch(frfx, frfy, 'blue');
            xxold = frfx;
            xyold = frfy;
        case 7  % F
            patch(ffx, ffy, 'blue');
            xxold = ffx;
            xyold = ffy;
    end %swftch
    
    
    disp('resting');
    pause(1.5); % Refresh time
    
%    patch(xold, yold, [0.8 0.8 0.8]);
    
    
    
end

fclose('all');
delete(instrfindall)