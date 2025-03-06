clear all;
clear device;

port = "COM3"; %去设备管理器里查一下485转接是占在哪个COM里，如果没有的话说明没装驱动。

%首次配置用cmd检查mode配置是否正确，如果不正确按照下面指令配置。
%mode COM4: baud=9600/115200 parity=N data=8 stop=1
baudRate = 115200;
device = serialport(port, baudRate);
device.DataBits = 8;
device.StopBits = 1;
device.Timeout = 2;

try
    %send/read
    modbusCmd = uint8([0x01, 0x04, 0x00, 0x00, 0x00, 0x02, 0x71, 0xCB]); 
    numBytes = 9; % 2*2 + 3 + 2
    while true
        write(device, modbusCmd, "uint8");
        response = read(device, numBytes, "uint8");
        %print
        if isempty(response)
            fprintf("%05.1f mm\n", "0");
        else
            distance = (  response(4) * 2^24 ...
                        + response(5) * 2^16 ...
                        + response(6) * 2^8 ...
                        + response(7) ...
                        ) / 10;
            fprintf("%05.1f mm\n", distance);
        end
    end
catch ME
    disp("ERROR");
end


