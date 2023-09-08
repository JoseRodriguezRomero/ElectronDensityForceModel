%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_50.chk
%Chk=O2_O2_51.chk

#p CCSD(T)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_51

-2 3
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.335809          0.000000          0.000000
O              2.983429          0.000000          0.000000

