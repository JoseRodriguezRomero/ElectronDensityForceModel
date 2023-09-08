%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_119.chk
%Chk=O2_O2_120.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_120

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.312751          0.000000          0.000000
O              3.960371          0.000000          0.000000

