%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_213.chk
%Chk=O2_O2_214.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_214

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.643658          0.000000          0.000000
O              5.291278          0.000000          0.000000

