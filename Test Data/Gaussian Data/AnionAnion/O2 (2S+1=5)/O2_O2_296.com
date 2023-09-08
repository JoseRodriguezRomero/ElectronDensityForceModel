%NProcShared=4
%Mem=4GB
%OldChk=O2_O2_295.chk
%Chk=O2_O2_296.chk

#p CCSD(T,MaxCyc=300)/cc-pVTZ Guess=Read SCF=XQC 

O2_O2_296

-2 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.804661          0.000000          0.000000
O              6.452281          0.000000          0.000000

