function HaplyInverse3_updateData(fileName, format, COM)
    t1 = tic;
    logFile = 'HaplyInverse3_updateDataLog.txt';
    fid = fopen(logFile, 'w');
    fclose(fid);
    
    diary(logFile);
    diary on;

    haply = HaplyInverse3_setup(COM);

    m = memmapfile(fileName, 'Format', format, 'Writable', true);

    disp("HaplyInverse3_updateData: START");
    disp("Time Spend: " + toc(t1));

    while m.Data.systemOn
        m.Data.haply_pos = HaplyInverse3_writeline(haply, "GetPos");

        if(m.Data.haply_meca_doZero(2))
            HaplyInverse3_writeline(haply, "DoZero", 20);
            m.Data.haply_meca_doZero(2) = 0;
        pause(0.05);
    end
    
    disp("HaplyInverse3_updateData: OVER");
    disp("Time Spend: " + toc(t1));
    
    diary off;
end

