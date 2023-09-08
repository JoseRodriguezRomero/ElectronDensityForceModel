%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_110.chk
%Chk=O2_O2_111.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_111

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.185324          0.000000          0.000000
O              3.832944          0.000000          0.000000

