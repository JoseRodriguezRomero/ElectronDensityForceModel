%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_56.chk
%Chk=O2_O2_57.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_57

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.420760          0.000000          0.000000
O              3.068380          0.000000          0.000000
