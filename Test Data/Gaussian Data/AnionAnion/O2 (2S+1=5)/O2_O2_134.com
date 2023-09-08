%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_133.chk
%Chk=O2_O2_134.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_134

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.510971          0.000000          0.000000
O              4.158591          0.000000          0.000000

