%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_47.chk
%Chk=O2_O2_48.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_48

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.293333          0.000000          0.000000
O              2.940953          0.000000          0.000000

