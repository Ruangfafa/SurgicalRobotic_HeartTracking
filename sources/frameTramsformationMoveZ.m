function t = frameTramsformationMoveZ(mecaPose, meca_moveZ)
    alpha = mecaPose(4);
    beta  = mecaPose(5);
    gamma = mecaPose(6);


    Rz = [cos(gamma), -sin(gamma), 0;
          sin(gamma),  cos(gamma), 0;
          0,           0,          1];
    
    Ry = [cos(beta),  0, sin(beta);
          0,         1, 0;
         -sin(beta), 0, cos(beta)];
    
    Rx = [1, 0,          0;
          0, cos(alpha), -sin(alpha);
          0, sin(alpha), cos(alpha)];

    R = Rx * Ry * Rz;


    moveZ_vector = [1; 0; 0];

    moveZ_transformed = R * moveZ_vector * meca_moveZ;

    mecaPose(1) = mecaPose(1) - moveZ_transformed(1);
    mecaPose(2) = mecaPose(2) - moveZ_transformed(2);
    mecaPose(3) = mecaPose(3) - moveZ_transformed(3);

    t = mecaPose;
    