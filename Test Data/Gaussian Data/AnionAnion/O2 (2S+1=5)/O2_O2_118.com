%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_117.chk
%Chk=O2_O2_118.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_118

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.284434          0.000000          0.000000
O              3.932054          0.000000          0.000000

