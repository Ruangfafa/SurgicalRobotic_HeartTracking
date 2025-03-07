function t = RangeFinder_writeline(device,command)
    switch command
        case "GetRange"
            try
                write(device, uint8([0x01, 0x04, 0x00, 0x00, 0x00, 0x02, 0x71, 0xCB]), "uint8");
                response = read(device, 9, "uint8");% 2*2 + 3 + 2
                if isempty(response)
                    t = 0;
                else
                    t = (  response(4) * 2^24 ...
                                + response(5) * 2^16 ...
                                + response(6) * 2^8 ...
                                + response(7) ...
                                ) / 10;
                end
            catch ME
                disp("ERROR: RangeFinder_getRange.m");
            end
        otherwise
            error("RangeFinder: Unknown command %s%s%s (RangeFinder_writeline.m)", char(34), command, char(34));
    end