%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_53.chk
%Chk=O2_O2_54.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_54

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.378284          0.000000          0.000000
O              3.025904          0.000000          0.000000

