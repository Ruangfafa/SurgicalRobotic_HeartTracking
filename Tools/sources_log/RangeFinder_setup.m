function t = RangeFinder_setup(COM,baudRate,dataBits,stopBits,timeout)
    t = serialport(COM, baudRate);
    t.DataBits = dataBits;
    t.StopBits = stopBits;
    t.Timeout = timeout;

