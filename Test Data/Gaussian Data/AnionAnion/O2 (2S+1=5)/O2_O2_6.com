%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_5.chk
%Chk=O2_O2_6.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_6

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.698672          0.000000          0.000000
O              2.346292          0.000000          0.000000

