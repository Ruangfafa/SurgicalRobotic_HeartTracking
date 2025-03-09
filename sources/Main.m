clear all;
clc;
addpath(fullfile(pwd, 'dependencies'));

disp("Main: START");

%========= Globals =========
global meca_moveX;
meca_moveX = 0; %1 / 0 / -1; Control the Meca500 moving on X-axis.

global meca_moveY;
meca_moveY = 0; %1 / 0 / -1; Control the Meca500 moving on Y-axis.

global meca_moveZ;
meca_moveY = 0; %1 / 0 / -1; Control the Meca500 moving on Z-axis.

global haply_meca_moveOption;
haply_meca_moveOption = false; %True / False; Define the Meca500 is moving or not relating on Inverse3.

global haply_meca_doZero;
haply_meca_doZero = false; %True / False; To zero the Meca500 joints and Inverse3.

global haply_workSpace;
haply_workSpace = [     -0.05   ,  0.135    ; 
                        -0.2    ,  -0.1     ; 
                        0       ,  0.3      ]; %[MinX, MaxX; MinY, MaxY; MinZ, MaxZ]; Define the workSpace for Inverse3, as a cuboid.
%===========================

%========== Setup ==========
rangeFinder = RangeFinder_setup("COM5", 115200, 8, 1, 2);
%meca = Meca500_setup(100);
haply = HaplyInverse3_setup("COM8");
%===========================


controlPanel = figure('Name', 'Press any key to start', 'NumberTitle', 'off'); %Set a window for control the loop.
pause = waitforbuttonpress; %Press to mark & start

while isvalid(controlPanel)
    if haply_meca_moveOption
    end
    
    if meca_moveX || meca_moveY || meca_moveZ
        Meca500_writeline(meca, "MoveLinRelWRF", [meca_moveX, meca_moveY, meca_moveZ, 0, 0, 0]);

    end

    if haply_meca_doZero
        Meca500_writeline(meca, "DoZero", 0);
        HaplyInverse3_writeline(haply, "DoZero", 20);
    end

end

disp("Main: OVER");
% distance_ref = RangeFinder_getRange(rangeFinder); %Mark the current distance as refference distance
% rangeFinder_difference = 0; %Initial value
% 
% while isvalid(fig) %Loop if the window is there
%      distance = RangeFinder_getRange(rangeFinder); %Get the current distance
% 
%      if(distance > 210 && distance < 590) %The distance limit for the Rangefinder
%          rangeFinder_difference = distance - distance_ref; %Get the distance difference
%      end
%      disp(rangeFinder_difference);
%          z_axis_WRF = 358 - rangeFinder_difference; %The default pos for z_axis_WRF is 308mm in Meca500
%     %     Meca500_writeline(meca,"MovePose",[190,0,z_axis_WRF,0,90,90]); %Move to the new location 
%     pos=HaplyInverse3_writeline(haply,"GetPos",0);
%     disp([pos(1),pos(2),pos(3)]);
%     disp("main loop running...");
%     tic;
%     while (toc < 0.05)
%     end
% end %Close the window to exit the loop

