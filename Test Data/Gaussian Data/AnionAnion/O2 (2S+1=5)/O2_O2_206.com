%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_205.chk
%Chk=O2_O2_206.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_206

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.530389          0.000000          0.000000
O              5.178009          0.000000          0.000000

