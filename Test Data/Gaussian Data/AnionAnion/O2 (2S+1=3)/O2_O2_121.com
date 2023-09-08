%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_120.chk
%Chk=O2_O2_121.chk

#p CCSD(T)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_121

-2 3
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.326909          0.000000          0.000000
O              3.974529          0.000000          0.000000

