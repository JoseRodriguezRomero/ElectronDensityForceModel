%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_118.chk
%Chk=O2_O2_119.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_119

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.298592          0.000000          0.000000
O              3.946212          0.000000          0.000000

