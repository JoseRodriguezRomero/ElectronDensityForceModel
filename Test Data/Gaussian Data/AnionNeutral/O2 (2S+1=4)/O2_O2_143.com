%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_142.chk
%Chk=O2_O2_143.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_143

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.638398          0.000000          0.000000
O              4.286018          0.000000          0.000000

