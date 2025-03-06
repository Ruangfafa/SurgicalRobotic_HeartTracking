clear all;
addpath("D:\SYSC4206\Project\sources")
%=====RangeFinder Setup=====
device = serialport("COM3", 115200); %serialport(port,baudRate)
device.DataBits = 8;
device.StopBits = 1;
device.Timeout = 2;
%===========================
%=======Meca500 Setup=======
value = 0;
t = mecaSetup;
%===========================
refference = RangeFinder_getRange(device);
k = waitforbuttonpress;
writeline(t,"SetJointVel(100)");
rangeFinder_difference = 0;
while true
    
    range = RangeFinder_getRange(device);
    if(range>210 && range < 590)
        rangeFinder_difference = range - refference;
    end
    value = double(get(gcf,'CurrentCharacter'));
    
    z_axis = 308 + rangeFinder_difference;
    rwriteline(t,"MovePose",[190,0,z_axis,0,90,0]);
    
    %开始计时
    tic;

        pose = Meca500_getPose(t);
        data_str = extractBetween(pose, "[", "]");
        data = str2num(data_str{2});
        result = data(3);
    while abs(result - z_axis) > 0.5
        pose = Meca500_getPose(t);
        data_str = extractBetween(pose, "[", "]");
        data = str2num(data_str{2});
        result = data(3);
        disp("wait");
    end
        %停止计时
        delay = toc*1000-63;
        %disp时间
        disp(['delay: ', num2str(delay), ' ms']);
    
end

    % rangeFinder_difference = RangeFinder_getRange(device) - refference;
    % fprintf("%05.1f mm\n", rangeFinder_difference);
