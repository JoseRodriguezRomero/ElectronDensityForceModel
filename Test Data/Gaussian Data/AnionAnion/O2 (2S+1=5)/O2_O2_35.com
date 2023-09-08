%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_34.chk
%Chk=O2_O2_35.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_35

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.109271          0.000000          0.000000
O              2.756891          0.000000          0.000000

