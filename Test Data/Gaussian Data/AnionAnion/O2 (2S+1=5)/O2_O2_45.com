%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_44.chk
%Chk=O2_O2_45.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_45

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.250857          0.000000          0.000000
O              2.898477          0.000000          0.000000

