%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_164.chk
%Chk=O2_O2_165.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_165

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.949887          0.000000          0.000000
O              4.597507          0.000000          0.000000

