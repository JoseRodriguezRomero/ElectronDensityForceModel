%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_190.chk
%Chk=O2_O2_191.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_191

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.318010          0.000000          0.000000
O              4.965630          0.000000          0.000000

