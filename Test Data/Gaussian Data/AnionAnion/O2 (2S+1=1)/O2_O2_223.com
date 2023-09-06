%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_222.chk
%Chk=O2_O2_223.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_223

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.771085          0.000000          0.000000
O              5.418705          0.000000          0.000000

