%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_257.chk
%Chk=O2_O2_258.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_258

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.266635          0.000000          0.000000
O              5.914255          0.000000          0.000000

