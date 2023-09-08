%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_242.chk
%Chk=O2_O2_243.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_243

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.054256          0.000000          0.000000
O              5.701876          0.000000          0.000000

