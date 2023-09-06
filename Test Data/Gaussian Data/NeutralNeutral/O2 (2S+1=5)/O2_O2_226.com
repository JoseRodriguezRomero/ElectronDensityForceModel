%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_225.chk
%Chk=O2_O2_226.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_226

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             10.013400          0.000000          0.000000
O              8.661020          0.000000          0.000000

