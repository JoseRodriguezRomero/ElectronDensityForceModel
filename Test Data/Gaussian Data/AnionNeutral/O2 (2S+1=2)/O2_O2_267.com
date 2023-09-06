%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_266.chk
%Chk=O2_O2_267.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_267

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.394062          0.000000          0.000000
O              6.041682          0.000000          0.000000

