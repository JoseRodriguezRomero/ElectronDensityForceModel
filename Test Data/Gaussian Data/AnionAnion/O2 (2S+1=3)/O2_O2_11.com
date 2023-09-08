%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_10.chk
%Chk=O2_O2_11.chk

#p CCSD(T)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_11

-2 3
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.769465          0.000000          0.000000
O              2.417085          0.000000          0.000000

