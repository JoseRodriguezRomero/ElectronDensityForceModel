%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_176.chk
%Chk=O2_O2_177.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_177

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.119790          0.000000          0.000000
O              4.767410          0.000000          0.000000

