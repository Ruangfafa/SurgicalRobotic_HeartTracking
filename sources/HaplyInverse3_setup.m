function t = HaplyInverse3_setup(COM)
    addpath(fullfile(pwd, 'dependencies'));
    t = HardwareAPI(COM, true, true);