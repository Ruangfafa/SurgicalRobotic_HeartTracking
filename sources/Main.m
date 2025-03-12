clear all;
clc;
addpath(fullfile(pwd, 'dependencies'));
batch('UIController')
disp("Main: START");

%========= Globals =========
global meca_moveX;
meca_moveX = 0; %1 / 0 / -1; Control the Meca500 moving on X-axis.

global meca_moveY;
meca_moveY = 0; %1 / 0 / -1; Control the Meca500 moving on Y-axis.

global meca_moveZ;
meca_moveZ = 0; %1 / 0 / -1; Control the Meca500 moving on Z-axis.

global meca_moveZSpeed;
meca_moveZSpeed = 5; %int; Define the Meca500 moving speed in Z-axis.

global meca_rangefinder_zAxisRelativelyStill;
meca_rangefinder_zAxisRelativelyStill = false; %True / False; Define the Meca500 will moving relatively still than the heart is z-axis.

global haply_meca_moveOption;
haply_meca_moveOption = false; %True / False; Define the Meca500 is moving or not relating on Inverse3.

global haply_meca_constraint;
haply_meca_constraint = false; %True / False; Define the Meca500 is moving with a given constraint, otherwise follow the tooltip.

global haply_meca_doZero;
haply_meca_doZero = false; %True / False; To zero the Meca500 joints and Inverse3.

global haply_workSpace;
haply_workSpace = [     -0.05   ,  0.135    ; 
                        -0.2    ,  -0.1     ; 
                        0       ,  0.3      ]; %[MinX, MaxX; MinY, MaxY; MinZ, MaxZ]; Define the workSpace for Inverse3, as a cuboid.
%===========================
while true
    disp(meca_moveX)
end
% %========== Setup ==========
% rangeFinder = RangeFinder_setup("COM5", 115200, 8, 1, 2);
% %meca = Meca500_setup(100);
% haply = HaplyInverse3_setup("COM8");
% %===========================
% 
% 
% controlPanel = figure('Name', 'Press any key to start', 'NumberTitle', 'off'); %Set a window for control the loop.
% pause = waitforbuttonpress; %Press to mark & start
% 
% while isvalid(controlPanel)
%     if haply_meca_moveOption && haply_meca_constraint
%     end
% 
%     if haply_meca_moveOption && ~haply_meca_constraint
%     end
% 
%     if (meca_moveX || meca_moveY) && ~haply_meca_moveOption
%         haply_meca_constraint = false;
%         Meca500_writeline(meca, "MoveLinRelWRF", [meca_moveX, meca_moveY, 0, 0, 0, 0]);
%     end
% 
%     if meca_moveZ
%         Meca500_writeline(meca, "MoveLinRelTRF", [0, 0, meca_moveZ, 0, 0, 0]);
%     end
% 
%     if haply_meca_doZero
%         Meca500_writeline(meca, "DoZero", 0);
%         HaplyInverse3_writeline(haply, "DoZero", 20);
%     end
% 
% end
% 
% disp("Main: OVER");