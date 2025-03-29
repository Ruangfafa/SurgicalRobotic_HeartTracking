function RangeFinder_updateRange(fileName, format, COM)
    rangeFinder = RangeFinder_setup(COM, 115200, 8, 1, 2);
    m = memmapfile(fileName, 'Format', format, 'Writable', true);
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