function dataFileFrequencyTest2(fileName, format)
    m = memmapfile(fileName, 'Format', format, 'Writable', true);
    m.Data.sync2 = 1;
    while m.Data.sync1 == 0 && m.Data.systemOn == 1
    end
    while m.Data.systemOn == 1;
        if m.Data.int1 ~= m.Data.int2
            m.Data.int2 = m.Data.int1;
        end
    end