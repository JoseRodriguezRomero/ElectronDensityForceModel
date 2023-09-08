%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_190.chk
%Chk=O2_O2_191.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_191

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.318010          0.000000          0.000000
O              4.965630          0.000000          0.000000

