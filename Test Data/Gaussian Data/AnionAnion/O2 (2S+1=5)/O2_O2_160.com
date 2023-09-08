%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_159.chk
%Chk=O2_O2_160.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_160

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.879094          0.000000          0.000000
O              4.526714          0.000000          0.000000

