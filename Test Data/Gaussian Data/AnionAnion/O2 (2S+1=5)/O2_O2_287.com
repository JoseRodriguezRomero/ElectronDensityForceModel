%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_286.chk
%Chk=O2_O2_287.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_287

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.677234          0.000000          0.000000
O              6.324854          0.000000          0.000000

