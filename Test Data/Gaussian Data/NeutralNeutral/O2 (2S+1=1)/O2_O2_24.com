%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_23.chk
%Chk=O2_O2_24.chk

#p ROCCSD(T,MaxCyc=350)/cc-pVTZ Guess=Read SCF=(VeryTight,MaxCycle=2500,CDIIS,VShift=10) 

O2_O2_24

0 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.293333          0.000000          0.000000
O              2.940953          0.000000          0.000000

