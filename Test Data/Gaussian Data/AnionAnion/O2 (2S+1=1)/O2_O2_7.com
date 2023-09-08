%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_6.chk
%Chk=O2_O2_7.chk

#p CCSD(T)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_7

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.712831          0.000000          0.000000
O              2.360451          0.000000          0.000000

