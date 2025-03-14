function Data_log(fileName, format)
    t1 = tic;
    logFile = 'dataLog.txt';
    fid = fopen(logFile, 'w');
    fclose(fid);
    
    diary(logFile);
    diary on;
    disp("Data_log: START");
    m = memmapfile(fileName, 'Format', format, 'Writable', true);

    tempM = [m.Data.systemOn, m.Data.meca_moveX, m.Data.meca_moveY, m.Data.meca_moveZ, m.Data.meca_moveZSpeed, m.Data.meca_rangefinder_zAxisRelativelyStill, m.Data.haply_meca_moveOption, m.Data.haply_meca_constraint, m.Data.haply_meca_doZero, m.Data.rangeFinder_range];
    fprintf('Elapsed time: %.3f seconds\n', toc(t1));
    disp([m.Data.systemOn, m.Data.meca_moveX, m.Data.meca_moveY, m.Data.meca_moveZ, m.Data.meca_moveZSpeed, m.Data.meca_rangefinder_zAxisRelativelyStill, m.Data.haply_meca_moveOption, m.Data.haply_meca_constraint, m.Data.haply_meca_doZero, m.Data.rangeFinder_range]);
    while m.Data.systemOn
        if ~isequal(tempM, [m.Data.systemOn, m.Data.meca_moveX, m.Data.meca_moveY, m.Data.meca_moveZ, m.Data.meca_moveZSpeed, m.Data.meca_rangefinder_zAxisRelativelyStill, m.Data.haply_meca_moveOption, m.Data.haply_meca_constraint, m.Data.haply_meca_doZero, m.Data.rangeFinder_range])
            fprintf('Elapsed time: %.3f seconds\n', toc(t1));
            disp([m.Data.systemOn, m.Data.meca_moveX, m.Data.meca_moveY, m.Data.meca_moveZ, m.Data.meca_moveZSpeed, m.Data.meca_rangefinder_zAxisRelativelyStill, m.Data.haply_meca_moveOption, m.Data.haply_meca_constraint, m.Data.haply_meca_doZero, m.Data.rangeFinder_range]);
            tempM = [m.Data.systemOn, m.Data.meca_moveX, m.Data.meca_moveY, m.Data.meca_moveZ, m.Data.meca_moveZSpeed, m.Data.meca_rangefinder_zAxisRelativelyStill, m.Data.haply_meca_moveOption, m.Data.haply_meca_constraint, m.Data.haply_meca_doZero, m.Data.rangeFinder_range];
        end
    end

    disp("Data_log: OVER");
    diary off;
end
