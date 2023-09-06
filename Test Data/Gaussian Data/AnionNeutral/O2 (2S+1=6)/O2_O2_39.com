%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_38.chk
%Chk=O2_O2_39.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_39

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.165906          0.000000          0.000000
O              2.813526          0.000000          0.000000

