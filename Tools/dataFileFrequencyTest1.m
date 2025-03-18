function dataFileFrequencyTest1(fileName, format)
    logFile = 'dataFileFrequencyTest1Log.txt';
    fid = fopen(logFile, 'w');
    fclose(fid);
    
    diary(logFile);
    diary on;

    m = memmapfile(fileName, 'Format', format, 'Writable', true);
    m.Data.sync1 = 1;
    counter = 0;
    while m.Data.sync2 == 0 && m.Data.systemOn == 1
    end
    t1 = tic;
    while m.Data.systemOn == 1
        t2 = tic;

        if m.Data.int1 == m.Data.int2 && m.Data.int1 == 1
            m.Data.int1 = 0;
            counter = counter+2;
        end
        if m.Data.int1 == m.Data.int2 && m.Data.int1 == 0
            m.Data.int1 = 1;
            counter = counter+2;
        end

        % while toc(t2)<0.05
        % end
        if toc(t1) >= 10
            m.Data.systemOn = 0;
        end
    end
    disp(counter);
    diary off;