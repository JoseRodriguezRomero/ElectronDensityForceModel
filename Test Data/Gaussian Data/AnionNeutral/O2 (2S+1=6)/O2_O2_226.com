%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_225.chk
%Chk=O2_O2_226.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_226

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.813561          0.000000          0.000000
O              5.461181          0.000000          0.000000

