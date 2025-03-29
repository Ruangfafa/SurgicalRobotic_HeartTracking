function Data_log(fileName, format)
    t1 = tic;
    logFile = 'dataLog.txt';
    fid = fopen(logFile, 'w');
    fclose(fid);
    
    diary(logFile);
    diary on;
    disp("Data_log: START");
    disp("Time Spend: " + toc(t1));
    m = memmapfile(fileName, 'Format', format, 'Writable', true);

    tempM = [m.Data.rangeFinder_range];
    fprintf('Elapsed time: %.3f seconds\n', toc(t1));
    disp([m.Data.rangeFinder_range]);
    while m.Data.systemOn
        if ~isequal(tempM, [m.Data.rangeFinder_range])
            fprintf('Elapsed time: %.3f seconds\n', toc(t1));
            disp([m.Data.rangeFinder_range]);
            tempM = [m.Data.rangeFinder_range];
        end
    end

    disp("Data_log: OVER");
    disp("Time Spend: " + toc(t1));
    diary off;
end
