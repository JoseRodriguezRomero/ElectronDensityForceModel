%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_135.chk
%Chk=O2_O2_136.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_136

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.539288          0.000000          0.000000
O              4.186908          0.000000          0.000000

