%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_289.chk
%Chk=O2_O2_290.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_290

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             11.825699          0.000000          0.000000
O             10.473319          0.000000          0.000000

