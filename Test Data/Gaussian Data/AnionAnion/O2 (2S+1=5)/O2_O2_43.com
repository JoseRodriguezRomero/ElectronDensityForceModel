%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_42.chk
%Chk=O2_O2_43.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_43

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.222540          0.000000          0.000000
O              2.870160          0.000000          0.000000

