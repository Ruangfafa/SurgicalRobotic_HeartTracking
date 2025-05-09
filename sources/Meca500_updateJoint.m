function Meca500_updateJoint(fileName, format)
    t1 = tic;
    logFile = 'Meca500_updateJointLog.txt';
    fid = fopen(logFile, 'w');
    fclose(fid);
    
    diary(logFile);
    diary on;

    meca = Meca500_setup(100);

    m = memmapfile(fileName, 'Format', format, 'Writable', true);
    disp("Meca500_updateJoint: START");
    disp("Time Spend: " + toc(t1));

    while m.Data.systemOn
        Meca500_writeline(meca, "MoveJoints", m.Data.meca_joints);
        if m.Data.haply_meca_doZero(1) 
            Meca500_writeline(meca, "DoZero", 0);
            m.Data.haply_meca_doZero(1) = 0;
        end
    end
    
    Meca500_writeline(meca, "MoveJoints", zeros(1,6));

    robot.delete();
    disp("Meca500_updateJoint: OVER");
    disp("Time Spend: " + toc(t1));
    
    diary off;
    
end

