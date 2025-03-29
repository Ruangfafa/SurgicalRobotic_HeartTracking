function t = HaplyInverse3_writeline(device,command)
haply_workSpace = [     -0.05   ,  0.135    ; 
                                -0.2    ,  -0.1     ; 
                                0       ,  0.3      ];
    switch command
        case "GetPos"
            %-0.05~0.135,-0.1~-0.2,0~0.3
            [pos, vel] = device.EndEffectorForce(zeros(3,1));
            t = [max(haply_workSpace(1,1), min(haply_workSpace(1,2), pos(1)));max(haply_workSpace(2,1), min(haply_workSpace(2,2), pos(2)));max(haply_workSpace(3,1), min(haply_workSpace(3,2), pos(3)))];
            disp(t);
        case "GetVel"
            [pos, vel] = device.EndEffectorForce(zeros(3,1));
            t = vel;

        case "DoZero"
            request = zeros(3,1);
            zeta = 2;
            dg = 0.006;
            zeroPos = mean(haply_workSpace, 2);
        
            while true
                [pos, vel] = device.EndEffectorForce(request);
                d = norm(pos - zeroPos);
        
                if d > dg
                    request = zeta * (zeroPos - pos) / (d);
                else
                    request = 20 * (zeroPos - pos);
                end
                if d < 0.003
                    t2 = tic;
                    while toc(t2) <= 1
                        [pos, vel] = device.EndEffectorForce(request);
                        d = norm(pos - zeroPos);
                        if d > dg
                            request = zeta * (zeroPos - pos) / (d);
                        else
                            request = 20 * (zeroPos - pos);
                        end
                    end
                    if norm(pos - zeroPos) < 0.004
                        t = 0;
                        break;
                    end
                end
        
                pause(0.005);
            end


            % request = zeros(3,1);
            % k = 50;
            % zeroX = mean(haply_workSpace(1, :));
            % zeroY = mean(haply_workSpace(2, :));
            % zeroZ = mean(haply_workSpace(3, :));
            % disp("do zero");
            % while true
            %     [pos, vel] = device.EndEffectorForce(request);
            %     request(1) = k*(zeroX-pos(1));
            %     request(2) = k*(zeroY-pos(2));
            %     request(3) = k*(zeroZ-pos(3));
            %     if pos(1) - zeroX < 0.0005 && pos(2) - zeroY  < 0.0005 && pos(3) - zeroZ < 0.0005 %error= ±0.5mm.
            %         tic;
            %         while toc <= 3
            %             [pos, vel] = device.EndEffectorForce(request);
            %             request(1) = k*(zeroX-pos(1));
            %             request(2) = k*(zeroY-pos(2));
            %             request(3) = k*(zeroZ-pos(3)); 
            %         end
            %         if pos(1) - zeroX < 0.0015 && pos(2) - zeroY  < 0.0015 &&pos(3) - zeroZ < 0.0015 %error= ±0.5mm.
            %         disp("stop");
            %             t=1;
            %             break;
            %         end
            %     end
            %     pause(0.05);
            % end

        otherwise
            t = 0;
            error("HaplyInverse3: Unknown command %s%s%s (HaplyInverse3_writeline.m)", char(34), command, char(34));
    end 

