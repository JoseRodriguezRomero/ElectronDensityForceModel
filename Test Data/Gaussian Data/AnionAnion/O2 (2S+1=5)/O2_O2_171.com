%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_170.chk
%Chk=O2_O2_171.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_171

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.034839          0.000000          0.000000
O              4.682459          0.000000          0.000000

