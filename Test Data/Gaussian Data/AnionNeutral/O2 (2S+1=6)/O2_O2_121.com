%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_120.chk
%Chk=O2_O2_121.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_121

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.326909          0.000000          0.000000
O              3.974529          0.000000          0.000000

