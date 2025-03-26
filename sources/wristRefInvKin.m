function q = wristRefInvKin(pose)
desired = wristVector(pose);

gain = 0.01;
error = 10.0;
thetaPrev = [0;0;0;0;0;0];
currentPosn = wristFwdKin(thetaPrev);
feedback = wristVector(currentPosn);
tic
while norm(error)>0.075||toc<0.01

    error = desired-feedback;
    Jinv = wristInvJacobian(thetaPrev,error*gain);
    theta = Jinv+thetaPrev;
    thetaPrev = theta;
    eulers = rotational(theta);
    theta = [theta(1,1);theta(2,1);theta(3,1);theta(4,1);theta(5,1);theta(6,1)+(pose(6,1)-eulers(3,1))];
    theta = [theta(1,1);theta(2,1);theta(3,1);theta(4,1);theta(5,1);theta(6,1)+(pose(4,1)-eulers(1,1))];
    currentPosn = wristFwdKin(theta);

    feedback = wristVector(currentPosn);

    error = desired-feedback;
end
q = double(theta*(180/pi));
end
function X_tilde = wristInvJacobian(theta,Y)
theta1 = theta(1,1);
theta2 = theta(2,1);
theta3 = theta(3,1);
theta4 = theta(4,1);
theta5 = theta(5,1);
theta6 = theta(6,1);

jacobian = [70*cos(theta5)*(cos(theta3)*sin(theta1)*sin(theta2 - pi/2) + cos(theta2 - pi/2)*sin(theta1)*sin(theta3)) - 70*sin(theta5)*(cos(theta1)*sin(theta4) - cos(theta4)*(cos(theta3)*cos(theta2 - pi/2)*sin(theta1) - sin(theta1)*sin(theta3)*sin(theta2 - pi/2))) - 135*cos(theta2 - pi/2)*sin(theta1) - 38*cos(theta3)*cos(theta2 - pi/2)*sin(theta1) + 120*cos(theta3)*sin(theta1)*sin(theta2 - pi/2) + 120*cos(theta2 - pi/2)*sin(theta1)*sin(theta3) + 38*sin(theta1)*sin(theta3)*sin(theta2 - pi/2), 70*cos(theta5)*(cos(theta1)*sin(theta3)*sin(theta2 - pi/2) - cos(theta1)*cos(theta3)*cos(theta2 - pi/2)) - 135*cos(theta1)*sin(theta2 - pi/2) - 38*cos(theta1)*cos(theta3)*sin(theta2 - pi/2) - 38*cos(theta1)*cos(theta2 - pi/2)*sin(theta3) + 120*cos(theta1)*sin(theta3)*sin(theta2 - pi/2) + 70*cos(theta4)*sin(theta5)*(cos(theta1)*cos(theta3)*sin(theta2 - pi/2) + cos(theta1)*cos(theta2 - pi/2)*sin(theta3)) - 120*cos(theta1)*cos(theta3)*cos(theta2 - pi/2), 70*cos(theta5)*(cos(theta1)*sin(theta3)*sin(theta2 - pi/2) - cos(theta1)*cos(theta3)*cos(theta2 - pi/2)) - 38*cos(theta1)*cos(theta3)*sin(theta2 - pi/2) - 38*cos(theta1)*cos(theta2 - pi/2)*sin(theta3) + 120*cos(theta1)*sin(theta3)*sin(theta2 - pi/2) + 70*cos(theta4)*sin(theta5)*(cos(theta1)*cos(theta3)*sin(theta2 - pi/2) + cos(theta1)*cos(theta2 - pi/2)*sin(theta3)) - 120*cos(theta1)*cos(theta3)*cos(theta2 - pi/2), -70*sin(theta5)*(cos(theta4)*sin(theta1) + sin(theta4)*(cos(theta1)*sin(theta3)*sin(theta2 - pi/2) - cos(theta1)*cos(theta3)*cos(theta2 - pi/2))), 70*sin(theta5)*(cos(theta1)*cos(theta3)*sin(theta2 - pi/2) + cos(theta1)*cos(theta2 - pi/2)*sin(theta3)) - 70*cos(theta5)*(sin(theta1)*sin(theta4) - cos(theta4)*(cos(theta1)*sin(theta3)*sin(theta2 - pi/2) - cos(theta1)*cos(theta3)*cos(theta2 - pi/2))), 0;
135*cos(theta1)*cos(theta2 - pi/2) - 70*sin(theta5)*(sin(theta1)*sin(theta4) - cos(theta4)*(cos(theta1)*sin(theta3)*sin(theta2 - pi/2) - cos(theta1)*cos(theta3)*cos(theta2 - pi/2))) - 70*cos(theta5)*(cos(theta1)*cos(theta3)*sin(theta2 - pi/2) + cos(theta1)*cos(theta2 - pi/2)*sin(theta3)) - 120*cos(theta1)*cos(theta3)*sin(theta2 - pi/2) - 120*cos(theta1)*cos(theta2 - pi/2)*sin(theta3) - 38*cos(theta1)*sin(theta3)*sin(theta2 - pi/2) + 38*cos(theta1)*cos(theta3)*cos(theta2 - pi/2), 120*sin(theta1)*sin(theta3)*sin(theta2 - pi/2) - 70*cos(theta5)*(cos(theta3)*cos(theta2 - pi/2)*sin(theta1) - sin(theta1)*sin(theta3)*sin(theta2 - pi/2)) - 120*cos(theta3)*cos(theta2 - pi/2)*sin(theta1) - 38*cos(theta3)*sin(theta1)*sin(theta2 - pi/2) - 38*cos(theta2 - pi/2)*sin(theta1)*sin(theta3) - 135*sin(theta1)*sin(theta2 - pi/2) + 70*cos(theta4)*sin(theta5)*(cos(theta3)*sin(theta1)*sin(theta2 - pi/2) + cos(theta2 - pi/2)*sin(theta1)*sin(theta3)), 120*sin(theta1)*sin(theta3)*sin(theta2 - pi/2) - 120*cos(theta3)*cos(theta2 - pi/2)*sin(theta1) - 38*cos(theta3)*sin(theta1)*sin(theta2 - pi/2) - 38*cos(theta2 - pi/2)*sin(theta1)*sin(theta3) - 70*cos(theta5)*(cos(theta3)*cos(theta2 - pi/2)*sin(theta1) - sin(theta1)*sin(theta3)*sin(theta2 - pi/2)) + 70*cos(theta4)*sin(theta5)*(cos(theta3)*sin(theta1)*sin(theta2 - pi/2) + cos(theta2 - pi/2)*sin(theta1)*sin(theta3)),  70*sin(theta5)*(cos(theta1)*cos(theta4) + sin(theta4)*(cos(theta3)*cos(theta2 - pi/2)*sin(theta1) - sin(theta1)*sin(theta3)*sin(theta2 - pi/2))), 70*cos(theta5)*(cos(theta1)*sin(theta4) - cos(theta4)*(cos(theta3)*cos(theta2 - pi/2)*sin(theta1) - sin(theta1)*sin(theta3)*sin(theta2 - pi/2))) + 70*sin(theta5)*(cos(theta3)*sin(theta1)*sin(theta2 - pi/2) + cos(theta2 - pi/2)*sin(theta1)*sin(theta3)), 0;
0,120*cos(theta3)*sin(theta2 - pi/2) - 38*cos(theta3)*cos(theta2 - pi/2) - 135*cos(theta2 - pi/2) + 120*cos(theta2 - pi/2)*sin(theta3) + 38*sin(theta3)*sin(theta2 - pi/2) + 70*cos(theta5)*(cos(theta3)*sin(theta2 - pi/2) + cos(theta2 - pi/2)*sin(theta3)) + 70*cos(theta4)*sin(theta5)*(cos(theta3)*cos(theta2 - pi/2) - sin(theta3)*sin(theta2 - pi/2)),120*cos(theta3)*sin(theta2 - pi/2) - 38*cos(theta3)*cos(theta2 - pi/2) + 120*cos(theta2 - pi/2)*sin(theta3) + 38*sin(theta3)*sin(theta2 - pi/2) + 70*cos(theta5)*(cos(theta3)*sin(theta2 - pi/2) + cos(theta2 - pi/2)*sin(theta3)) + 70*cos(theta4)*sin(theta5)*(cos(theta3)*cos(theta2 - pi/2) - sin(theta3)*sin(theta2 - pi/2)),-70*sin(theta4)*sin(theta5)*(cos(theta3)*sin(theta2 - pi/2) + cos(theta2 - pi/2)*sin(theta3)),70*sin(theta5)*(cos(theta3)*cos(theta2 - pi/2) - sin(theta3)*sin(theta2 - pi/2)) + 70*cos(theta4)*cos(theta5)*(cos(theta3)*sin(theta2 - pi/2) + cos(theta2 - pi/2)*sin(theta3)), 0;
120*cos(theta3)*sin(theta1)*sin(theta2 - pi/2) - 38*cos(theta3)*cos(theta2 - pi/2)*sin(theta1) - 135*cos(theta2 - pi/2)*sin(theta1) + 120*cos(theta2 - pi/2)*sin(theta1)*sin(theta3) + 38*sin(theta1)*sin(theta3)*sin(theta2 - pi/2),120*cos(theta1)*sin(theta3)*sin(theta2 - pi/2) - 38*cos(theta1)*cos(theta3)*sin(theta2 - pi/2) - 38*cos(theta1)*cos(theta2 - pi/2)*sin(theta3) - 135*cos(theta1)*sin(theta2 - pi/2) - 120*cos(theta1)*cos(theta3)*cos(theta2 - pi/2),120*cos(theta1)*sin(theta3)*sin(theta2 - pi/2) - 38*cos(theta1)*cos(theta2 - pi/2)*sin(theta3) - 38*cos(theta1)*cos(theta3)*sin(theta2 - pi/2) - 120*cos(theta1)*cos(theta3)*cos(theta2 - pi/2),0,0, 0;
135*cos(theta1)*cos(theta2 - pi/2) - 120*cos(theta1)*cos(theta3)*sin(theta2 - pi/2) - 120*cos(theta1)*cos(theta2 - pi/2)*sin(theta3) - 38*cos(theta1)*sin(theta3)*sin(theta2 - pi/2) + 38*cos(theta1)*cos(theta3)*cos(theta2 - pi/2),120*sin(theta1)*sin(theta3)*sin(theta2 - pi/2) - 120*cos(theta3)*cos(theta2 - pi/2)*sin(theta1) - 38*cos(theta3)*sin(theta1)*sin(theta2 - pi/2) - 38*cos(theta2 - pi/2)*sin(theta1)*sin(theta3) - 135*sin(theta1)*sin(theta2 - pi/2),120*sin(theta1)*sin(theta3)*sin(theta2 - pi/2) - 38*cos(theta3)*sin(theta1)*sin(theta2 - pi/2) - 38*cos(theta2 - pi/2)*sin(theta1)*sin(theta3) - 120*cos(theta3)*cos(theta2 - pi/2)*sin(theta1),0,0, 0;
0,120*cos(theta3)*sin(theta2 - pi/2) - 38*cos(theta3)*cos(theta2 - pi/2) - 135*cos(theta2 - pi/2) + 120*cos(theta2 - pi/2)*sin(theta3) + 38*sin(theta3)*sin(theta2 - pi/2),120*cos(theta3)*sin(theta2 - pi/2) - 38*cos(theta3)*cos(theta2 - pi/2) + 120*cos(theta2 - pi/2)*sin(theta3) + 38*sin(theta3)*sin(theta2 - pi/2),0,0, 0];
 
pseudoinverse = pinv(jacobian);
X_tilde = double(pseudoinverse*Y);
end
function orientation = rotational(theta)
%% convert theta from deg to rad
theta1 = theta(1,1);
theta2 = theta(2,1);
theta3 = theta(3,1);
theta4 = theta(4,1);
theta5 = theta(5,1);
theta6 = theta(6,1);

%% DH link lengths
r1 = 135;
a2 = 135;
a3 = 38;
r4 = 120;
r6 = 70;
%% transformation matrices using DH parameters
H01 = [cos(theta1) 0 -sin(theta1) 0;
    sin(theta1) 0 cos(theta1) 0;
    0 -1 0 r1;
    0 0 0 1];
H12 = [cos(theta2-(pi/2)) -sin(theta2-(pi/2)) 0 a2*cos(theta2-(pi/2));
    sin(theta2-(pi/2)) cos(theta2-(pi/2)) 0 a2*sin(theta2-(pi/2));
    0 0 1 0;
    0 0 0 1];
H23 = [cos(theta3) 0 -sin(theta3) a3*cos(theta3);
    sin(theta3) 0 cos(theta3) a3*sin(theta3);
    0 -1 0 0;
    0 0 0 1];
H34 = [cos(theta4) 0 sin(theta4) 0;
    sin(theta4) 0 -cos(theta4) 0;
    0 1 0 r4;
    0 0 0 1];
H45 = [cos(theta5) 0 -sin(theta5) 0;
    sin(theta5) 0 cos(theta5) 0;
    0 -1 0 0;
    0 0 0 1];
H56 = [cos(theta6+pi) -sin(theta6+pi) 0 0;
    sin(theta6+pi) cos(theta6+pi) 0 0;
    0 0 1 r6;
    0 0 0 1];
A = H01*H12*H23*H34*H45*H56;

%% euler angle extraction
if abs(A(1,3)) > 0.99 && abs(A(1,3)) < 1.01
    beta = pi/2;
    alpha = atan2(A(2,1),A(2,2));
    gamma = 0;
else
    beta = asin(A(1,3));
    gamma = atan2(-A(1,2),A(1,1));
    alpha = atan2(-A(2,3),A(3,3));
end

% fprintf('Alpha: %f\n',alpha*180/pi);
% fprintf('Beta: %f\n',beta*180/pi);
% fprintf('Gamma: %f\n',gamma*180/pi);
orientation = [alpha;beta;gamma];
end
function pose = wristFwdKin(theta)
%% convert theta from deg to rad
theta1 = theta(1,1);
theta2 = theta(2,1);
theta3 = theta(3,1);
theta4 = theta(4,1);
theta5 = theta(5,1);
theta6 = theta(6,1);

%% DH link lengths
r1 = 135;
a2 = 135;
a3 = 38;
r4 = 120;
r6 = 70;
%% transformation matrices using DH parameters
H01 = [cos(theta1) 0 -sin(theta1) 0;
    sin(theta1) 0 cos(theta1) 0;
    0 -1 0 r1;
    0 0 0 1];
H12 = [cos(theta2-(pi/2)) -sin(theta2-(pi/2)) 0 a2*cos(theta2-(pi/2));
    sin(theta2-(pi/2)) cos(theta2-(pi/2)) 0 a2*sin(theta2-(pi/2));
    0 0 1 0;
    0 0 0 1];
H23 = [cos(theta3) 0 -sin(theta3) a3*cos(theta3);
    sin(theta3) 0 cos(theta3) a3*sin(theta3);
    0 -1 0 0;
    0 0 0 1];
H34 = [cos(theta4) 0 sin(theta4) 0;
    sin(theta4) 0 -cos(theta4) 0;
    0 1 0 r4;
    0 0 0 1];
H45 = [cos(theta5) 0 -sin(theta5) 0;
    sin(theta5) 0 cos(theta5) 0;
    0 -1 0 0;
    0 0 0 1];
H56 = [cos(theta6+pi) -sin(theta6+pi) 0 0;
    sin(theta6+pi) cos(theta6+pi) 0 0;
    0 0 1 r6;
    0 0 0 1];
A = H01*H12*H23*H34*H45*H56;

%% euler angle extraction
if abs(A(1,3)) > 0.99 && abs(A(1,3)) < 1.01
    beta = pi/2;
    alpha = atan2(A(2,1),A(2,2));
    gamma = 0;
else
    beta = asin(A(1,3));
    gamma = atan2(-A(1,2),A(1,1));
    alpha = atan2(-A(2,3),A(3,3));
end

% fprintf('Alpha: %f\n',alpha*180/pi);
% fprintf('Beta: %f\n',beta*180/pi);
% fprintf('Gamma: %f\n',gamma*180/pi);
pose = [A(1,4);A(2,4);A(3,4);alpha;beta;gamma];
end
function Y = wristVector(X)
alpha = X(4,1);
beta = X(5,1);
gamma = X(6,1);
R06 = [cos(beta)*cos(gamma) -cos(beta)*sin(gamma) sin(beta);
    cos(alpha)*sin(gamma)+sin(alpha)*sin(beta)*cos(gamma) cos(alpha)*cos(gamma)-sin(alpha)*sin(beta)*sin(gamma) -sin(alpha)*cos(beta);
    sin(alpha)*sin(gamma)-cos(alpha)*sin(beta)*cos(gamma) sin(alpha)*cos(gamma)+cos(alpha)*sin(beta)*sin(gamma) cos(alpha)*cos(beta)];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = X(1,1);
y = X(2,1);
z = X(3,1);

perpendicular_directional = R06*[0;0;1];
t = -70*sqrt(perpendicular_directional(1,1)^2+perpendicular_directional(2,1)^2+perpendicular_directional(3,1)^2)/(perpendicular_directional(1,1)^2+perpendicular_directional(2,1)^2+perpendicular_directional(3,1)^2);
x_w = x+t*perpendicular_directional(1,1);
y_w = y+t*perpendicular_directional(2,1);
z_w = z+t*perpendicular_directional(3,1);

Y = [x;y;z;x_w;y_w;z_w];
end