%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_228.chk
%Chk=O2_O2_229.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_229

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.856036          0.000000          0.000000
O              5.503656          0.000000          0.000000

