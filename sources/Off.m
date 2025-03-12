function sysOff()
    diary('sysOffLog.txt');
    diary on;
    global systemOn;
    tic

    disp(systemOn);
    while toc < 20
    end
    systemOn = false;
    disp(systemOn);

    diary off;