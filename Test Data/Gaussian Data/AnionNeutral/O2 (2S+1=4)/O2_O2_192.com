%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_191.chk
%Chk=O2_O2_192.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_192

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.332169          0.000000          0.000000
O              4.979789          0.000000          0.000000

