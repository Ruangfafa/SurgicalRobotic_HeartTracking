function System(fileName, format)
    t1 = tic;
    logFile = 'systemLog.txt';
    fid = fopen(logFile, 'w');
    fclose(fid);
    
    diary(logFile);
    diary on;
    addpath(fullfile(pwd, 'dependencies'));
    
    m = memmapfile(fileName, 'Format', format, 'Writable', true);
    disp("System: START");
    disp("Time Spend: " + toc(t1));
    %========== Setup ==========
    %meca = Meca500_setup(100);
    %haply = HaplyInverse3_setup("COM9");
    %===========================
    %======== Variables ========
    global haply_workSpace;
    haply_workSpace = [     -0.05   ,  0.135    ; 
                            -0.2    ,  -0.1     ; 
                            0       ,  0.3      ]; %[MinX, MaxX; MinY, MaxY; MinZ, MaxZ]; Define the workSpace for Inverse3, as a cuboid.
    meca_shift = [0, 0, 0];
    %===========================
    
    while m.Data.systemOn
        pos = HaplyInverse3_writeline(haply, "GetPos");
        if m.Data.haply_meca_moveOption && m.Data.haply_meca_constraint
        end
    
        if m.Data.haply_meca_moveOption && ~m.Data.haply_meca_constraint
            const = []; %0.0425 -0.15 0.15, 190 0 308
        end
    
        if (m.Data.meca_moveX || m.Data.meca_moveY) && ~m.Data.haply_meca_moveOption
            %Meca500_writeline(meca, "MoveLinRelWRF", [meca_moveX, meca_moveY, 0, 0, 0, 0]);
 
        end
    
        if m.Data.meca_moveZ
            %Meca500_writeline(meca, "MoveLinRelTRF", [0, 0, meca_moveZ, 0, 0, 0]);
           
        end
    
        if m.Data.haply_meca_doZero
            meca_shift = [0, 0, 0];
            %Meca500_writeline(meca, "DoZero", 0);
            %HaplyInverse3_writeline(haply, "DoZero", 20);
            m.Data.haply_meca_doZero = 0;
        end
    end
    disp("System: OVER");
    disp("Time Spend: " + toc(t1));
    diary off;

