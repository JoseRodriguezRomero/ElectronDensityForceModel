%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_26.chk
%Chk=O2_O2_27.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_27

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.996003          0.000000          0.000000
O              2.643623          0.000000          0.000000

