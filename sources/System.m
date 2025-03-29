function System(fileName, format)


    addpath(fullfile(pwd, 'dependencies'));
    
    m = memmapfile(fileName, 'Format', format, 'Writable', true);


    %======== Variables ========
    haply_workSpace = [     -0.05   ,  0.135    ; 
                            -0.2    ,  -0.1     ; 
                            0       ,  0.3      ]; %[MinX, MaxX; MinY, MaxY; MinZ, MaxZ]; Define the workSpace for Inverse3, as a cuboid.
    mecaPose = [190,0,308,pi/100,pi/2,pi/8];%[190,0,308,0,pi/2,pi/6]
    const = [190+100*m.Data.haply_pos(1), 0-100*m.Data.haply_pos(2), 108+100*m.Data.haply_pos(3)];
    setZ = 1;
    rangeFinder_freqCompCounter = 0;

    constZ = 0;
    tempRange = 0;

    setHaplyZ = 1;
    constHaply = zeros(1,3);
    noteLast = 0;
    %===========================
    
    while m.Data.systemOn
        if m.Data.haply_meca_moveOption
            if setHaplyZ == 1
                constHaply = m.Data.haply_pos;
                setHaplyZ = 0;
            end
            haplyDeltaZ = 200*(m.Data.haply_pos(3)-constHaply(3));
            noteLast = 1;
            % if ~m.Data.haply_meca_constraint
            %     const = [190+100*m.Data.haply_pos(1), 0-100*m.Data.haply_pos(2), 108+100*m.Data.haply_pos(3)]; %0.0425 -0.15 0.15, 190 0 308
            %     pos_const = [m.Data.haply_pos(1),m.Data.haply_pos(2),m.Data.haply_pos(3)];
            % end
            % 
            % posn = [const(1)-50*(m.Data.haply_pos(1)-pos_const(1)),const(2)+50*(m.Data.haply_pos(2)-pos_const(2)),150*m.Data.haply_pos(3)+5];
            % mecaPose = sixDOFinversekin(posn.',const.');
        else
            if  noteLast == 1
                noteLast = 0;
                mecaPose = frameTramsformationMoveZ(mecaPose,haplyDeltaZ);
            end
            haplyDeltaZ = 0;
            setHaplyZ = 1;
        end

        if (m.Data.meca_moveX || m.Data.meca_moveY) && ~m.Data.haply_meca_moveOption
            %Meca500_writeline(meca, "MoveLinRelWRF", [meca_moveX, meca_moveY, 0, 0, 0, 0]);
            mecaPose(1) = mecaPose(1) + m.Data.meca_moveX;
            mecaPose(2) = mecaPose(2) + m.Data.meca_moveY;
            
        end
    
        if m.Data.meca_rangefinder_zAxisRelativelyStill;
            if setZ
                constZ = m.Data.rangeFinder_range;
                setZ = 0;
                deltaZ = 0;
            end
            
            if abs(m.Data.rangeFinder_range - constZ) <= 50
                tempRange = m.Data.rangeFinder_range;
                deltaZ = max([min([tempRange - constZ,1]),-1]);
            else
                deltaZ = 0;
            end
            mecaPose = frameTramsformationMoveZ(mecaPose,-deltaZ*0.8);
        else
            setZ = 1;
        end

        if m.Data.meca_moveZ
            
            %Meca500_writeline(meca, "MoveLinRelTRF", [0, 0, meca_moveZ, 0, 0, 0]);
            mecaPose = frameTramsformationMoveZ(mecaPose,m.Data.meca_moveZ);
        end
    
        if m.Data.haply_meca_doZero(1)
            mecaPose = [190,0,308,0,pi/2,0];
        end

        mecaPose = frameTramsformationMoveZ(mecaPose,haplyDeltaZ);
        m.Data.meca_joints = wristRefInvKin(mecaPose.');
        mecaPose = frameTramsformationMoveZ(mecaPose,-haplyDeltaZ);

    end

