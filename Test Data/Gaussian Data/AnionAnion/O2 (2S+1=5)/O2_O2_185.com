%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_184.chk
%Chk=O2_O2_185.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_185

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.233059          0.000000          0.000000
O              4.880679          0.000000          0.000000

