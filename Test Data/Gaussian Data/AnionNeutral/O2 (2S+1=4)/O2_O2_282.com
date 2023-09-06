%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_281.chk
%Chk=O2_O2_282.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_282

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.606441          0.000000          0.000000
O              6.254061          0.000000          0.000000

