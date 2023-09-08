%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_285.chk
%Chk=O2_O2_286.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_286

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.663075          0.000000          0.000000
O              6.310695          0.000000          0.000000

