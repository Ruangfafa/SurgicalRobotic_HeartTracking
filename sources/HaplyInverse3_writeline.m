function t = HaplyInverse3_writeline(device,command)
    switch command
        case "GetPos"
            %-0.05~0.135,-0.1~-0.2,0~0.3
            global haply_workSpace;
            [pos, vel] = haply.EndEffectorForce(zeros(3,1));
            t = [max(haply_workSpace(1,1), min(haply_workSpace(1,2), pos(1))),max(haply_workSpace(2,1), min(haply_workSpace(2,2), pos(2))),max(haply_workSpace(3,1), min(haply_workSpace(3,2), pos(3)))];

        case "GetVel"
            [pos, vel] = device.EndEffectorForce(zeros(3,1));
            t = vel;

        case "DoZero"
            global haply_workSpace;
            request = zeros(3,1);
            k = 50;
            zeroX = mean(haply_workSpace(1, :));
            zeroY = mean(haply_workSpace(2, :));
            zeroZ = mean(haply_workSpace(3, :));

            while true
                [pos, vel] = device.EndEffectorForce(request);
                request(1) = k*(zeroX-pos(1));
                request(2) = k*(zeroY-pos(2));
                request(3) = k*(zeroZ-pos(3));

                    disp(abs(pos - [zeroX, zeroY, zeroZ]));
                if all(abs(pos - [zeroX, zeroY, zeroZ]) < 0.0005) %error= ±0.5mm.
                    disp("stop");
                    % tic;
                    % while toc <= 3
                    %     % we wait. 
                    % end
                    % if all(abs(pos - [zeroX, zeroY, zeroZ]) < 0.0005) %error= ±0.5mm.
                    %     break;
                    % end
                    break;
                end

                tic;
                while toc <= 0.005
                    % we wait. 
                end
            end

        otherwise
            error("HaplyInverse3: Unknown command %s%s%s (HaplyInverse3_writeline.m)", char(34), command, char(34));
    end
