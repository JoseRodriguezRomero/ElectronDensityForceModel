%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_39.chk
%Chk=O2_O2_40.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_40

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.180064          0.000000          0.000000
O              2.827684          0.000000          0.000000

