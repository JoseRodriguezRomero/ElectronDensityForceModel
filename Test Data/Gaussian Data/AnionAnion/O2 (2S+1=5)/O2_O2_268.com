%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_267.chk
%Chk=O2_O2_268.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_268

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.408221          0.000000          0.000000
O              6.055841          0.000000          0.000000

