%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_8.chk
%Chk=O2_O2_9.chk

#p CCSD(T)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_9

-2 3
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.741148          0.000000          0.000000
O              2.388768          0.000000          0.000000

