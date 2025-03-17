fileName = fullfile(pwd, 'data.dat');
format = {
    'double',    [1, 1], 'systemOn';
    'double',    [1, 1], 'sync1';
    'double',    [1, 1], 'sync2';
    'double',    [1, 1], 'int1';
    'double',    [1, 1], 'int2';
    };

fid = fopen(fileName, 'w+');
fwrite(fid, zeros(40, 1), 'uint8');
fclose(fid);

m = memmapfile(fileName, 'Format', format, 'Writable', true);

m.Data.systemOn = 1;
m.Data.sync1 = 0;
m.Data.sync2 = 0;
m.Data.int1 = 0;
m.Data.int2 = 0;

p = gcp('nocreate');
if isempty(p)
    p = parpool;
end

f1 = parfeval(@dataFileFrequencyTest1, 0, fileName, format);
f2 = parfeval(@dataFileFrequencyTest2, 0, fileName, format);
clear all;