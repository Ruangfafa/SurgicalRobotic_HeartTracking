function Meca500_updateJoint(fileName, format)

    meca = Meca500_setup(100);

    m = memmapfile(fileName, 'Format', format, 'Writable', true);

    while m.Data.systemOn
        Meca500_writeline(meca, "MoveJoints", m.Data.meca_joints);
        if m.Data.haply_meca_doZero(1) 
            Meca500_writeline(meca, "DoZero", 20);
            m.Data.haply_meca_doZero(1) = 0;
        end
    end


    robot.delete();
end

