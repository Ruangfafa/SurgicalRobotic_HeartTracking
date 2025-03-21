function t = frameTramsformation(mecaPose)
    Rz = [cos(gamma), -sin(gamma), 0;
          sin(gamma),  cos(gamma), 0;
          0,           0,          1];
    
    Ry = [cos(beta),  0, sin(beta);
          0,         1, 0;
         -sin(beta), 0, cos(beta)];
    
    Rx = [1, 0,          0;
          0, cos(alpha), -sin(alpha);
          0, sin(alpha), cos(alpha)];

    R = Rz * Ry * Rx;
    t = mecaPose;
