%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_31.chk
%Chk=O2_O2_32.chk

#p ROCCSD(T,MaxCyc=350)/cc-pVTZ Guess=Read SCF=(VeryTight,MaxCycle=2500,CDIIS,VShift=10) 

O2_O2_32

0 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.519870          0.000000          0.000000
O              3.167490          0.000000          0.000000

