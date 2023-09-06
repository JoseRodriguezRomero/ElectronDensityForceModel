%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_279.chk
%Chk=O2_O2_280.chk

#p ROCCSD(T,MaxCyc=350)/cc-pVTZ Guess=Read SCF=(VeryTight,MaxCycle=2500,CDIIS,VShift=10) 

O2_O2_280

0 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             11.542527          0.000000          0.000000
O             10.190147          0.000000          0.000000

