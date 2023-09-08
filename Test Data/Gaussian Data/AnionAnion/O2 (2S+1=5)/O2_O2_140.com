%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_139.chk
%Chk=O2_O2_140.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_140

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.595922          0.000000          0.000000
O              4.243542          0.000000          0.000000

