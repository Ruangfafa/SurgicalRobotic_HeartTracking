function t = Meca500_writeline(device,command,data)
    switch command
        case "MovePose"

            input = sprintf("MovePose(%f,%f,%f,%f,%f,%f)", data(1), data(2), data(3), data(4), data(5), data(6));
            writeline(meca, input);
            t = 1;

        case "MoveLinRelWRF"
            input = sprintf("MoveLinRelWRF(%f,%f,%f,%f,%f,%f)", data(1), data(2), data(3), data(4), data(5), data(6));
            writeline(meca, input);
            t = 1;

        case "MoveLinRelTRF"
            input = sprintf("MoveLinRelTRF(%f,%f,%f,%f,%f,%f)", data(1), data(2), data(3), data(4), data(5), data(6));
            writeline(meca, input);
            t = 1;

        case "SetJointVel"
            if data <= 100 && data > 0
                input = sprintf("SetJointVel(%f)", data);
                writeline(device, input);
            else
                input = sprintf("SetJointVel(%f)", data);
                writeline(device, input);
            end
            t = data;

        case "GetPose"
            writeline(device, "GetPose");
            message = readline(device); %return as string format: "[2026][x,y,z,α,β,γ]"
            message_str = extractBetween(message, "[", "]");
            pose = str2num(message_str{2});
            switch data
                case "x"
                    t = pose(1);
                case "y"
                    t = pose(2);
                case "z"
                    t = pose(3);
                case "α"
                    t = pose(4);
                case "β"
                    t = pose(5);
                case "γ"
                    t = pose(6);
                otherwise
                    t = pose;
            end

        case "DoZero"
            writeline(meca,'MovePose(190,0,358,0,90,90)');

        otherwise
            error("Meca500: Unknown command %s%s%s (Meca500_writeline.m)", char(34), command, char(34));
    end