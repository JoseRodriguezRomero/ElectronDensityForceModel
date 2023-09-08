%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_237.chk
%Chk=O2_O2_238.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_238

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.983464          0.000000          0.000000
O              5.631084          0.000000          0.000000

