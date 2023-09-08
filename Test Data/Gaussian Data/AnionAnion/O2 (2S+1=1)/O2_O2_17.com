%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_16.chk
%Chk=O2_O2_17.chk

#p CCSD(T)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_17

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.854417          0.000000          0.000000
O              2.502037          0.000000          0.000000

