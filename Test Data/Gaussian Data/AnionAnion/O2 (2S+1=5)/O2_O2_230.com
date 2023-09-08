%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_229.chk
%Chk=O2_O2_230.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_230

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.870195          0.000000          0.000000
O              5.517815          0.000000          0.000000

