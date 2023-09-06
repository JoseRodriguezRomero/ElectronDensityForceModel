%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_246.chk
%Chk=O2_O2_247.chk

#p ROCCSD(T,MaxCyc=350)/cc-pVTZ Guess=Read SCF=(VeryTight,MaxCycle=2500,CDIIS,VShift=10) 

O2_O2_247

0 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             10.608060          0.000000          0.000000
O              9.255680          0.000000          0.000000

