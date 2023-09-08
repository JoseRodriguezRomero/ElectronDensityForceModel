%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_140.chk
%Chk=O2_O2_141.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_141

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.610081          0.000000          0.000000
O              4.257701          0.000000          0.000000

