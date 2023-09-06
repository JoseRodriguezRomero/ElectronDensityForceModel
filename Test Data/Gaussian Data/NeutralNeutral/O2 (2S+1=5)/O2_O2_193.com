%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_192.chk
%Chk=O2_O2_193.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_193

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              9.078934          0.000000          0.000000
O              7.726554          0.000000          0.000000

