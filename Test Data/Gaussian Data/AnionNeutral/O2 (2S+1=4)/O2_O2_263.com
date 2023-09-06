%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_262.chk
%Chk=O2_O2_263.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_263

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.337428          0.000000          0.000000
O              5.985048          0.000000          0.000000

