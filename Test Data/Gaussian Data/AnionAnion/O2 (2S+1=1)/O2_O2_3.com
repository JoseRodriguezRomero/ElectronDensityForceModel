%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_2.chk
%Chk=O2_O2_3.chk

#p CCSD(T)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_3

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.656197          0.000000          0.000000
O              2.303817          0.000000          0.000000

