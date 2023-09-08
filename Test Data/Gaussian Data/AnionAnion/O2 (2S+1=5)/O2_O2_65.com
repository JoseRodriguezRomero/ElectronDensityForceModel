%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_64.chk
%Chk=O2_O2_65.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_65

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.534029          0.000000          0.000000
O              3.181649          0.000000          0.000000

