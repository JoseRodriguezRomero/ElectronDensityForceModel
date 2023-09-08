%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_31.chk
%Chk=O2_O2_32.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_32

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.066796          0.000000          0.000000
O              2.714416          0.000000          0.000000

