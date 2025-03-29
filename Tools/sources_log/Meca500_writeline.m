function t = Meca500_writeline(device,command,data)
    switch command
        case "MovePose"
            input = sprintf("MovePose(%f,%f,%f,%f,%f,%f)", data(1), data(2), data(3), data(4), data(5), data(6));
            writeline(device, input);
            t = 1;
        
        case "MoveJoints"
            input = sprintf("MoveJoints(%f,%f,%f,%f,%f,%f)", data(1), data(2), data(3), data(4), data(5), data(6));
            writeline(device, input);
            t = 1;

        case "MoveLinRelWRF"
            input = sprintf("MoveLinRelWRF(%f,%f,%f,%f,%f,%f)", data(1), data(2), data(3), data(4), data(5), data(6));
            writeline(device, input);
            t = 1;

        case "MoveLinRelTRF"
            input = sprintf("MoveLinRelTRF(%f,%f,%f,%f,%f,%f)", data(1), data(2), data(3), data(4), data(5), data(6));
            writeline(device, input);
            t = 1;

        case "SetJointVel"
            input = sprintf("SetJointVel(%f)", max(0, min(100, data)));
            writeline(device, input);
            t = data;

        case "GetPose"
            writeline(device, "GetPose");
            message = readline(device); %return as string format: "[2026][x,y,z,α,β,γ]"
            message_str = extractBetween(message, "[", "]");
            pose = str2num(message_str{2});
            t = pose;

        case "DoZero"
            writeline(device,'MoveJoints(0,0,0,0,0,0)');

        otherwise
            error("Meca500: Unknown command %s%s%s (Meca500_writeline.m)", char(34), command, char(34));
    end