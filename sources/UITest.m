% This Scipt only used for testing the UI itself works or not

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
    'double',    [1, 1], 'haply_meca_doZero'%True / False; To zero the Meca500 joints and Inverse3.
    'double',    [1, 1], 'rangeFinder_range'
};

m = memmapfile(fileName, 'Format', format, 'Writable', true);

m.Data.systemOn = 1;
m.Data.meca_moveX = 0;
m.Data.meca_moveY = 0;
m.Data.meca_moveZ = 0;
m.Data.meca_moveZSpeed = 5;
m.Data.meca_rangefinder_zAxisRelativelyStill = 0;
m.Data.haply_meca_moveOption = 0;
m.Data.haply_meca_constraint = 0;
m.Data.haply_meca_doZero = 0;
m.Data.rangeFinder_range = 0;


controlPanel = UIController(fileName, format);