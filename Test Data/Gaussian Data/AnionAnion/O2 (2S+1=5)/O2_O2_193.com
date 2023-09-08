%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_192.chk
%Chk=O2_O2_193.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_193

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.346327          0.000000          0.000000
O              4.993947          0.000000          0.000000

