%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_30.chk
%Chk=O2_O2_31.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_31

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.052637          0.000000          0.000000
O              2.700257          0.000000          0.000000

