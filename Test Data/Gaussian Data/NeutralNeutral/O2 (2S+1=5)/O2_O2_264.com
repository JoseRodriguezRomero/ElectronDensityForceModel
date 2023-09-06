%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_263.chk
%Chk=O2_O2_264.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_264

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             11.089452          0.000000          0.000000
O              9.737072          0.000000          0.000000

