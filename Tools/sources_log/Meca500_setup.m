function t = Meca500_setup(vel)
    echotcpip('on',10000);
    t = tcpclient('192.168.0.100',10000);
    fopen(t); 
    t.Status;
    configureTerminator(t,00); 
    writeline(t,'ActivateRobot');
    writeline(t,'Home');
    writeline(t,'ResetError');
    writeline(t,'SetEOB(0)');
    get(t,{ 'RemoteHost','RemotePort'}) %'Name','RemoteHost','RemotePort','Type'
    writeline(t,'MovePose(190,0,308,0,90,0)');
    command = sprintf("SetJointVel(%f)", vel);
    writeline(t,command);
    disp("Meca500: Ready");

