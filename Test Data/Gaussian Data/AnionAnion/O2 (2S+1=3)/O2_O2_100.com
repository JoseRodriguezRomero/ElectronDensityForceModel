%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_99.chk
%Chk=O2_O2_100.chk

#p CCSD(T)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_100

-2 3
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.029579          0.000000          0.000000
O              3.677199          0.000000          0.000000

