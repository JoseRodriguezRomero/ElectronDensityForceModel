%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_166.chk
%Chk=O2_O2_167.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_167

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.978204          0.000000          0.000000
O              4.625824          0.000000          0.000000

