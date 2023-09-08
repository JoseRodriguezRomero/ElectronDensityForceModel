%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_22.chk
%Chk=O2_O2_23.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_23

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.939368          0.000000          0.000000
O              2.586988          0.000000          0.000000

