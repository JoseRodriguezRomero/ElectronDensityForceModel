%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_7.chk
%Chk=O2_O2_8.chk

#p CCSD(T)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_8

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.726990          0.000000          0.000000
O              2.374610          0.000000          0.000000

