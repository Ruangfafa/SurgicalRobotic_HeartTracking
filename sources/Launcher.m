clear all;
clc;

fileName = fullfile(pwd, 'data.dat');
format = {
    'double',    [1, 1], 'systemOn';
    'double',    [1, 1], 'meca_moveX';%1 / 0 / -1; Control the Meca500 moving on X-axis.
    'double',    [1, 1], 'meca_moveY';%1 / 0 / -1; Control the Meca500 moving on Y-axis.
    'double',    [1, 1], 'meca_moveZ';%1 / 0 / -1; Control the Meca500 moving on Z-axis.
    'double',    [1, 1], 'meca_moveZSpeed';%int; Define the Meca500 moving speed in Z-axis.
    'double',    [1, 1], 'meca_rangefinder_zAxisRelativelyStill';%True / False; Define the Meca500 will moving relatively still than the heart is z-axis.
    'double',    [1, 1], 'haply_meca_moveOption';%True / False; Define the Meca500 is moving or not relating on Inverse3.
    'double',    [1, 1], 'haply_meca_constraint';%True / False; Define the Meca500 is moving with a given constraint, otherwise follow the tooltip.
    'double',    [1, 2], 'haply_meca_doZero';%True / False; To zero the Meca500 joints and Inverse3.
    'double',    [1, 1], 'rangeFinder_range';
    'double',    [1, 6], 'meca_joints';
    'double',    [1, 3], 'haply_pos';
    'double',    [1, 3], 'haply_vel';
};
fid = fopen(fileName, 'w');
fwrite(fid, zeros(184, 1), 'uint8');
fclose(fid);

m = memmapfile(fileName, 'Format', format, 'Writable', true);

m.Data.systemOn = 1;
m.Data.meca_moveX = 0;
m.Data.meca_moveY = 0;
m.Data.meca_moveZ = 0;
m.Data.meca_moveZSpeed = 5;
m.Data.meca_rangefinder_zAxisRelativelyStill = 0;
m.Data.haply_meca_moveOption = 0;
m.Data.haply_meca_constraint = 0;
m.Data.haply_meca_doZero = zeros(1, 2);
m.Data.rangeFinder_range = 0;
m.Data.meca_joints = zeros(1, 6);
m.Data.haply_pos = zeros(1, 3);
m.Data.haply_vel = zeros(1, 3);

p = gcp('nocreate');
if isempty(p)
    p = parpool;
end

controlPanel = UIController(fileName, format);
drawnow;
f1 = parfeval(@System, 0, fileName, format);
f2 = parfeval(@RangeFinder_updateRange, 0, fileName, format, "COM5");
f3 = parfeval(@Meca500_updateJoint, 0, fileName, format);
%f4 = parfeval(@HaplyInverse3_updateData, 0, fileName, format, "COM4");
f5 = parfeval(@Data_log, 0, fileName, format);
