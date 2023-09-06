%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_37.chk
%Chk=O2_O2_38.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_38

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.151747          0.000000          0.000000
O              2.799367          0.000000          0.000000

