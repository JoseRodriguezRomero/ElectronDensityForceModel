%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_153.chk
%Chk=O2_O2_154.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_154

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.794143          0.000000          0.000000
O              4.441763          0.000000          0.000000

