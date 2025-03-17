function out = createFile()
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
};
    fileName = {fileName};
    out = {fileName, format};
    out.cells = out(:);
end
