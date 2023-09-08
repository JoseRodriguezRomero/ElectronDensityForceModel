%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_292.chk
%Chk=O2_O2_293.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_293

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.762186          0.000000          0.000000
O              6.409806          0.000000          0.000000

