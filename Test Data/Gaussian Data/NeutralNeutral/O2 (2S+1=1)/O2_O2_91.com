%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_90.chk
%Chk=O2_O2_91.chk

#p ROCCSD(T,MaxCyc=350)/cc-pVTZ Guess=Read SCF=(VeryTight,MaxCycle=2500,CDIIS,VShift=10) 

O2_O2_91

0 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.190583          0.000000          0.000000
O              4.838203          0.000000          0.000000

