%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_1.chk
%Chk=O2_O2_2.chk

#p CCSD(T)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_2

-2 3
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.642038          0.000000          0.000000
O              2.289658          0.000000          0.000000

