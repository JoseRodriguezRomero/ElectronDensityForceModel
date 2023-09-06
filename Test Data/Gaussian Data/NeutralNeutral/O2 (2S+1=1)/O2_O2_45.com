%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_44.chk
%Chk=O2_O2_45.chk

#p ROCCSD(T,MaxCyc=350)/cc-pVTZ Guess=Read SCF=(VeryTight,MaxCycle=2500,CDIIS,VShift=10) 

O2_O2_45

0 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.887993          0.000000          0.000000
O              3.535613          0.000000          0.000000

