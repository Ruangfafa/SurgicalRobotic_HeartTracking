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
    %======== Variables ========
    haply_workSpace = [     -0.05   ,  0.135    ; 
                            -0.2    ,  -0.1     ; 
                            0       ,  0.3      ]; %[MinX, MaxX; MinY, MaxY; MinZ, MaxZ]; Define the workSpace for Inverse3, as a cuboid.
    mecaPose = [190,0,308,0,pi/2,0];%[190,0,308,0,pi/2,pi/6]
    const = [190+100*m.Data.haply_pos(1), 0-100*m.Data.haply_pos(2), 108+100*m.Data.haply_pos(3)];
    setZ = 1;

     constZ = 0;
    %===========================
    
    while m.Data.systemOn
    
        if m.Data.haply_meca_moveOption
            if ~m.Data.haply_meca_constraint
                const = [190+100*m.Data.haply_pos(1), 0-100*m.Data.haply_pos(2), 108+100*m.Data.haply_pos(3)]; %0.0425 -0.15 0.15, 190 0 308
                disp(const);
                pos_const = [m.Data.haply_pos(1),m.Data.haply_pos(2),m.Data.haply_pos(3)];
                disp(pos_const);
            end

            posn = [const(1)-50*(m.Data.haply_pos(1)-pos_const(1)),const(2)+50*(m.Data.haply_pos(2)-pos_const(2)),150*m.Data.haply_pos(3)+5];
            disp(posn)
            mecaPose = sixDOFinversekin(posn.',const.');
            disp(mecaPose);
        end

        if (m.Data.meca_moveX || m.Data.meca_moveY) && ~m.Data.haply_meca_moveOption
            %Meca500_writeline(meca, "MoveLinRelWRF", [meca_moveX, meca_moveY, 0, 0, 0, 0]);
            mecaPose(1) = mecaPose(1) + m.Data.meca_moveX;
            mecaPose(2) = mecaPose(2) + m.Data.meca_moveY;
            
        end
    
        if m.Data.meca_rangefinder_zAxisRelativelyStill
                if setZ
                    constZ = m.Data.rangeFinder_range;
                    disp("constz");
                    disp(constZ);
                    setZ = 0;
                    deltaZ = 0;
                end
                temp = 0;
                if m.Data.rangeFinder_range == temp
                    deltaZ = 0;
                elseif abs(m.Data.rangeFinder_range - constZ) <= 50 && abs(m.Data.rangeFinder_range - constZ) >= 15
                    temp = m.Data.rangeFinder_range;
                    deltaZ = max([min([m.Data.rangeFinder_range - constZ,0.7]),-0.7]);
                end
                disp("deltaz");
                disp(deltaZ);
                mecaPose = frameTramsformationMoveZ(mecaPose,-deltaZ);
                disp(mecaPose);
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


        m.Data.meca_joints = wristRefInvKin(mecaPose.');

    end
    disp("System: OVER");
    disp("Time Spend: " + toc(t1));
    diary off;

