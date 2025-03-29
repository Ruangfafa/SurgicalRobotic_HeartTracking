function RangeFinder_updateRange(fileName, format, COM)
    t1 = tic;
    logFile = 'RangeFinder_updateRangeLog.txt';
    fid = fopen(logFile, 'w');
    fclose(fid);
    
    diary(logFile);
    diary on;
    rangeFinder = RangeFinder_setup(COM, 115200, 8, 1, 2);
    m = memmapfile(fileName, 'Format', format, 'Writable', true);
    disp("RangeFinder_updateRangeLog: START");
    disp("Time Spend: " + toc(t1));
    m.Data.rangeFinder_range = 0;
    while m.Data.systemOn
        try
            write(rangeFinder, uint8([0x01, 0x04, 0x00, 0x00, 0x00, 0x02, 0x71, 0xCB]), "uint8");
            response = read(rangeFinder, 9, "uint8");% 2*2 + 3 + 2
            if ~isempty(response)
                m.Data.rangeFinder_range = (  response(4) * 2^24 ...
                            + response(5) * 2^16 ...
                            + response(6) * 2^8 ...
                            + response(7) ...
                            ) / 10;
            end
        catch ME
            disp("ERROR: RangeFinder_getRange.m");
        end
    end
    disp("RangeFinder_updateRangeLog: OVER");
    disp("Time Spend: " + toc(t1));
    
    diary off;