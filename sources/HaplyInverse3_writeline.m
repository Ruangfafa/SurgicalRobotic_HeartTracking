function t = HaplyInverse3_writeline(device,command)
    switch command
        case "GetPos"
            %-0.05~0.135,-0.1~-0.2,0~0.3
            [pos, vel] = device.EndEffectorForce(zeros(3,1));
            t = [max(-0.05, min(0.135, pos(1))),max(-0.2, min(-0.1, pos(2))),max(0, min(0.3, pos(3)))];
        case "GetVel"
            [pos, vel] = device.EndEffectorForce(zeros(3,1));
            t = vel;
        otherwise
            error("HaplyInverse3: Unknown command %s%s%s (HaplyInverse3_writeline.m)", char(34), command, char(34));
    end
