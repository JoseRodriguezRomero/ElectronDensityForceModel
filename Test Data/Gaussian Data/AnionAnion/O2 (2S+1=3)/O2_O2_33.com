%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_32.chk
%Chk=O2_O2_33.chk

#p CCSD(T)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_33

-2 3
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.080954          0.000000          0.000000
O              2.728574          0.000000          0.000000

