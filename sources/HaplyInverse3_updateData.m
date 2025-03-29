function HaplyInverse3_updateData(fileName, format, COM)
    haply = HaplyInverse3_setup(COM);
    haply_workSpace = [     -0.05   ,  0.135    ; 
                                -0.2    ,  -0.1     ; 
                                0       ,  0.3      ];
    m = memmapfile(fileName, 'Format', format, 'Writable', true);

    while m.Data.systemOn
        pos = HaplyInverse3_writeline(haply, "GetPos")
        m.Data.haply_pos(1) = pos(1); 
        m.Data.haply_pos(2) = pos(2); 
        m.Data.haply_pos(3) = pos(3); 
        if(m.Data.haply_meca_doZero(2))
            eric = HaplyInverse3_writeline(haply, "DoZero")
            m.Data.haply_meca_doZero(2) = 0;
        end

        pause(0.05);
    end
    
    diary off;
end

