function set = needleConstrainedFwdKin(desired,constrained,theta)
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
H67 = [1 0 0 190;
    0 1 0 0;
    0 0 1 0;
    0 0 0 1];
l = 190-sqrt((desired(1,1)-constrained(1,1))^2+(desired(2,1)-constrained(2,1))^2+(desired(3,1)-constrained(3,1))^2);

H6C = [1 0 0 l;
    0 1 0 0;
    0 0 1 0;
    0 0 0 1];

A = H01*H12*H23*H34*H45*H56*H67;
B = H01*H12*H23*H34*H45*H56*H6C;

%% euler angle extraction
% if abs(A(1,3)) > 0.99 && abs(A(1,3)) < 1.01
%     beta = pi/2;
%     alpha = atan2(A(2,1),A(2,2));
%     gamma = 0;
% else
%     beta = asin(A(1,3));
%     gamma = atan2(-A(1,2),A(1,1));
%     alpha = atan2(-A(2,3),A(3,3));
% end

% fprintf('Alpha: %f\n',alpha*180/pi);
% fprintf('Beta: %f\n',beta*180/pi);
% fprintf('Gamma: %f\n',gamma*180/pi);
set = [A(1,4);A(2,4);A(3,4);B(1,4);B(2,4);B(3,4)];