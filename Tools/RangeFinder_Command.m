clear all;
clear device;

port = "COM5"; %去设备管理器里查一下485转接是占在哪个COM里，如果没有的话说明没装驱动。

%首次配置用cmd检查mode配置是否正确，如果不正确按照下面指令配置。
%mode COM4: baud=9600 parity=N data=8 stop=1
baudRate = 115200;
device = serialport(port, baudRate);
device.DataBits = 8;
device.StopBits = 1;
device.Timeout = 2;

modbusCmd = uint8([0x01, 0x04, 0x00, 0x0E, 0x00, 0x02, 0x10, 0x08]); 
numBytes = 9; % 2*2 + 3 + 2
%modbusCmd = uint8([0x01, 0x10, 0x00, 0x0E, 0x00, 0x02, 0x04, 0x00, 0x1F, 0x40, 0x00, 0xF1, 0x43]); 
tic; % 计时开始
try
    write(device, modbusCmd, "uint8");
    response = read(device, numBytes, "uint8");
    if ~isempty(response)
        distance = (  response(4) * 2^24 ...
                    + response(5) * 2^16 ...
                    + response(6) * 2^8 ...
                    + response(7) ...
                    );
        disp(distance);
    end
catch ME
    disp("ERROR");
end
