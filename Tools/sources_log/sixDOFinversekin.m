function  q = sixDOFinversekin(position,constraint)
str1 = 'MoveJoints(';
str2 = ',';
str3 = ')';
posn = [position(1,1);position(2,1);position(3,1)];
reference = [position(1,1);position(2);position(3,1);constraint(1,1);constraint(2,1);constraint(3,1)];
gain = 0.01;
error = 10.0;
theta_prev = zeros(6,1);
%% Assign 'current_posn' to the returned value of the forward kinamatics function
current_Posn = needleConstrainedFwdKin(posn,constraint,theta_prev);
disp("pos in 6");
disp(current_Posn);
while norm(error)>0.01 %condition
    %% Reassign error value
    %error = position-feedback;
    %% Jinv = (call to inverse jacobian)
    Jinv = needleConstrainedInvJacobian(constraint,posn,theta_prev);
    %% Assign 'theta_dot' = product of 'error', 'gain', and inverse Jacobian
    theta_dot = Jinv * error * gain;
    %% Discrete integration: Add 'theta_prev' and 'theta' variables, and store them in 'theta'
    theta = theta_prev + theta_dot;
    %% Assign the new value of 'theta' to be 'theta_prev' for the next iteration
    theta_prev = theta;
    %% Update 'current_posn'
    current_Posn = needleConstrainedFwdKin(current_Posn,constraint,theta);
    %% Update 'error'
    error = reference-current_Posn;
end


%% Return theta in degrees
%q = theta/pi*180;
q = current_Posn.';