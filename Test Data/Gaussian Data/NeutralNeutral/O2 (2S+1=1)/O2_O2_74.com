%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_73.chk
%Chk=O2_O2_74.chk

#p ROCCSD(T,MaxCyc=350)/cc-pVTZ Guess=Read SCF=(VeryTight,MaxCycle=2500,CDIIS,VShift=10) 

O2_O2_74

0 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.709191          0.000000          0.000000
O              4.356811          0.000000          0.000000

