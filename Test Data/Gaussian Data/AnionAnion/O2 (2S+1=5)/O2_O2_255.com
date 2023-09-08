%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_254.chk
%Chk=O2_O2_255.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_255

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.224159          0.000000          0.000000
O              5.871779          0.000000          0.000000

