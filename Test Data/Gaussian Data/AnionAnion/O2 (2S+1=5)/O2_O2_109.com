%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_108.chk
%Chk=O2_O2_109.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_109

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.157006          0.000000          0.000000
O              3.804626          0.000000          0.000000

