%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_205.chk
%Chk=O2_O2_206.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_206

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.530389          0.000000          0.000000
O              5.178009          0.000000          0.000000

