%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_213.chk
%Chk=O2_O2_214.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_214

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              9.673594          0.000000          0.000000
O              8.321214          0.000000          0.000000

