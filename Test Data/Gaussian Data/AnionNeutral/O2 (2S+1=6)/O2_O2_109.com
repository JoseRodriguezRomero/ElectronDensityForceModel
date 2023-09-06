%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_108.chk
%Chk=O2_O2_109.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_109

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.157006          0.000000          0.000000
O              3.804626          0.000000          0.000000

