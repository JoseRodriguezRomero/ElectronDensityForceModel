%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_220.chk
%Chk=O2_O2_221.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_221

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.742768          0.000000          0.000000
O              5.390388          0.000000          0.000000

