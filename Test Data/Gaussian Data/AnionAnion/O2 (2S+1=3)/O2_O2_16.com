%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_15.chk
%Chk=O2_O2_16.chk

#p CCSD(T)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_16

-2 3
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.840258          0.000000          0.000000
O              2.487878          0.000000          0.000000

