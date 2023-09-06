%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_132.chk
%Chk=O2_O2_133.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_133

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.496812          0.000000          0.000000
O              4.144432          0.000000          0.000000

