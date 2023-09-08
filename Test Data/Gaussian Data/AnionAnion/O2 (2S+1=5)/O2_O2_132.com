%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_131.chk
%Chk=O2_O2_132.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_132

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.482654          0.000000          0.000000
O              4.130274          0.000000          0.000000

