%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_49.chk
%Chk=O2_O2_50.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_50

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.321650          0.000000          0.000000
O              2.969270          0.000000          0.000000

