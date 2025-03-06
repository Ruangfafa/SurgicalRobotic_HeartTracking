% 清除已有的串口对象
clear all;
clear device;

% 设置串口参数
port = "COM4";  % 修改为你的实际端口
baudRate = 9600; % 设备当前的波特率（不是 115200，而是它当前运行的波特率）
device = serialport(port, baudRate);
device.DataBits = 8;
device.StopBits = 1;
device.Timeout = 2;

% 115200 波特率 Modbus 指令
modbusCmd = uint8([0x01, 0x10, 0x00, 0x0E, 0x00, 0x02, 0x04, 0x00, 0x1C, 0x20, 0x00, 0xAA, 0x25]); 

% 发送指令
write(device, modbusCmd, "uint8");

% 读取设备响应
numBytes = 8;
response = read(device, numBytes, "uint8");

% 显示返回数据
disp("设备响应:");
disp(response);

% 关闭串口
clear device;
