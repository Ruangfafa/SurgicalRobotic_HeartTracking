clear all;
clc;
addpath(fullfile(pwd, 'dependencies'));

disp("Main: START");

%========== Setup ==========
rangeFinder = RangeFinder_setup("COM5",115200,8,1,2);
%meca = Meca500_setup(100);
haply = HaplyInverse3_setup("COM8");
%===========================

fig = figure('Name', 'Press any key to start', 'NumberTitle', 'off'); %Set a window for control the loop
pause = waitforbuttonpress; %Press to mark & start
distance_ref = RangeFinder_writeline(rangeFinder,"GetRange"); %Mark the current distance as refference distance
rangeFinder_difference = 0; %Initial value

while isvalid(fig) %Loop if the window is there
     distance = RangeFinder_writeline(rangeFinder,"GetRange"); %Get the current distance
     
     if(distance > 210 && distance < 590) %The distance limit for the Rangefinder
         rangeFinder_difference = distance - distance_ref; %Get the distance difference
     end
     disp(rangeFinder_difference);
         z_axis_WRF = 358 - rangeFinder_difference; %The default pos for z_axis_WRF is 308mm in Meca500
    %     Meca500_writeline(meca,"MovePose",[190,0,z_axis_WRF,0,90,90]); %Move to the new location 
    pos=HaplyInverse3_writeline(haply,"GetPos");
    disp([pos(1),pos(2),pos(3)]);
    disp("main loop running...");
    tic;
    while (toc < 0.05)
    end
end %Close the window to exit the loop

disp("Main: OVER");
