%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_121.chk
%Chk=O2_O2_122.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_122

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.341068          0.000000          0.000000
O              3.988688          0.000000          0.000000

