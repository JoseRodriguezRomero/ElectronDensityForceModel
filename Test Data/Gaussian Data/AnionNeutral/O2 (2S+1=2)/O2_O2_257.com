%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_256.chk
%Chk=O2_O2_257.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_257

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.252477          0.000000          0.000000
O              5.900097          0.000000          0.000000

