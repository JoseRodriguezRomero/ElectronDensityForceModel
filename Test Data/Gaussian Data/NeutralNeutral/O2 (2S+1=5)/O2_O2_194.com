%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_193.chk
%Chk=O2_O2_194.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_194

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              9.107251          0.000000          0.000000
O              7.754871          0.000000          0.000000

