%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_115.chk
%Chk=O2_O2_116.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_116

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.256117          0.000000          0.000000
O              3.903737          0.000000          0.000000

