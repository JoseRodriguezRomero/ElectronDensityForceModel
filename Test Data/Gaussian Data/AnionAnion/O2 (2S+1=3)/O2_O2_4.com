%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_3.chk
%Chk=O2_O2_4.chk

#p CCSD(T)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_4

-2 3
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.670355          0.000000          0.000000
O              2.317975          0.000000          0.000000

