clear all
haplybot = HaplyInverse3_setup("COM10");
global haply_workSpace;
    haply_workSpace = [     -0.05   ,  0.135    ; 
                            -0.2    ,  -0.1     ; 
                            0       ,  0.3      ];
HaplyInverse3_writeline(haplybot,"DoZero")