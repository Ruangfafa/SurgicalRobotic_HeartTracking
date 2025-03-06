clear all;

addpath('D:\SYSC4206\Project\sources');

%=====RangeFinder Setup=====
device = serialport("COM3", 115200); %serialport(port,baudRate)
device.DataBits = 8;
device.StopBits = 1;
device.Timeout = 2;
%===========================

%=====RangeFinder Data======
x_axis = []; %array for time collect
y_axis = []; %array for range collect
t_start = tic; %Pin the start time
counter = 0;

while toc(t_start) <= 5 %The time for data collecting
    x_axis(end+1) = toc(t_start);
    y_axis(end+1) = RangeFinder_getRange(device);

    counter = counter + 1;

    if(counter > 3)
    
    end
    while toc(t_start) < (1 / 60) * counter end %Vertical Sync(垂直同步，尽量保持间隔为60Hz)
end
%===========================

%=====RangeFinder Plot======
figure;
plot(x_axis, y_axis, 'b-o', 'MarkerSize', 1, 'LineWidth', 0.3);
xlabel('Time (s)');
ylabel('Distance (mm)');
title('RangeFinder Data');
grid on;
xlim([min(x_axis)-1, max(x_axis)+1]);
ylim([min(y_axis)-5, max(y_axis)+5]);
%===========================