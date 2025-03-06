function returnRange = RangeFinder_getRange(device)
    try
    %send/read
    modbusCmd = uint8([0x01, 0x04, 0x00, 0x00, 0x00, 0x02, 0x71, 0xCB]); 
    numBytes = 9; % 2*2 + 3 + 2
    write(device, modbusCmd, "uint8");
    response = read(device, numBytes, "uint8");

    if isempty(response)
        returnRange = 0;
    else
        distance = (  response(4) * 2^24 ...
                    + response(5) * 2^16 ...
                    + response(6) * 2^8 ...
                    + response(7) ...
                    ) / 10;
        returnRange = distance;
    end
    catch ME
        disp("ERROR: RangeFinder_getRange.m");
    end