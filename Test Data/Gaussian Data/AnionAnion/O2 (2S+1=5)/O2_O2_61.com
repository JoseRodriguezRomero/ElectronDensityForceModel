%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_60.chk
%Chk=O2_O2_61.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_61

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.477394          0.000000          0.000000
O              3.125014          0.000000          0.000000

