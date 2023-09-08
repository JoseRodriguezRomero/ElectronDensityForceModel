%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_67.chk
%Chk=O2_O2_68.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_68

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.576505          0.000000          0.000000
O              3.224125          0.000000          0.000000

