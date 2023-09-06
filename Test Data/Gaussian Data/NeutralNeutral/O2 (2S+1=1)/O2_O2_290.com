%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_289.chk
%Chk=O2_O2_290.chk

#p ROCCSD(T,MaxCyc=350)/cc-pVTZ Guess=Read SCF=(VeryTight,MaxCycle=2500,CDIIS,VShift=10) 

O2_O2_290

0 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             11.825699          0.000000          0.000000
O             10.473319          0.000000          0.000000

