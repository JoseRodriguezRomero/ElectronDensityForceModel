%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_7.chk
%Chk=O2_O2_8.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_8

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.726990          0.000000          0.000000
O              2.374610          0.000000          0.000000

