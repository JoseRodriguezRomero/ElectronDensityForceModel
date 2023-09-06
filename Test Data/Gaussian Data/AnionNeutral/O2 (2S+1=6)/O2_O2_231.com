%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_230.chk
%Chk=O2_O2_231.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_231

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.884353          0.000000          0.000000
O              5.531973          0.000000          0.000000

